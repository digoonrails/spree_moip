require 'spec_helper'
require 'ephemeral_response'
require 'builder'

describe SpreeMoip::Moip do
  
  let :valid_id do
    Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  let :params do
    {:reason => "Mensalidade", :id => valid_id, :value => 1}
  end
  
  before :all do
    EphemeralResponse.activate
    @response = SpreeMoip::Moip.authorize(:reason => "Mensalidade",:id => valid_id, :value => 1)
  end

  after :all do
    EphemeralResponse.deactivate
  end
  
  # it "truth" do
  #   assert_kind_of Module, Moip
  # end
  
  describe '#authorize' do
    it "should have status Sucesso" do
      @response["Status"].should == "Sucesso"
    end
      
    it "should have a Token" do
      @response["Token"].should be_present
    end
    
    it "should have an ID" do
      @response["ID"].should be_present
    end
    
    it "should have xml data of client" do
      CONFIG = YAML.load_file(File.join(::Rails.root, 'config', 'gateway.yml'))[::Rails.env]
      
      SpreeMoip::Moip.send(:request_body, params).should eq simple_xml(params)
    end
    
    context "error" do
      
      context "required informations" do
        it "should raise an error without any of the required info" do
          params = {:reason => "Mensalidade", :id => valid_id, :value => nil}
          lambda { SpreeMoip::Moip.authorize(params) }.should raise_error("Invalid data to do the request")
          
          params = {:reason => "Mensalidade", :id => nil, :value => 1}
          lambda { SpreeMoip::Moip.authorize(params) }.should raise_error("Invalid data to do the request")
          
          params = {:reason => nil, :id => valid_id, :value => 1}
          lambda { SpreeMoip::Moip.authorize(params) }.should raise_error("Invalid data to do the request")
        end
      end

      it "should raise a exception if status is not success" do
        invalid_request = File.open(File.join(File.dirname(__FILE__), '../fixtures/moip_error.xml')).read

        SpreeMoip::Moip.stub(:perform_request).and_return(invalid_request)        
        lambda { SpreeMoip::Moip.authorize(params) }.should raise_error("Fail to authorize")
      end

      it "should raise a exception if response is nil" do
        SpreeMoip::Moip.class_eval do
          self.stub(:perform_request).and_return(nil)
        end
      
        lambda do
          SpreeMoip::Moip.authorize(params)
        end.should raise_error("Webservice can't be reached")
      end
    end

  end
end

def simple_xml(args)
  xml = Builder::XmlMarkup.new.EnviarInstrucao do |e|
    e.InstrucaoUnica("TipoValidacao" => "Transparent") do |i|
      i.Razao args[:reason]
      i.IdProprio args[:id]
      i.URLRetorno CONFIG['uri_return']
      i.URLNotificacao CONFIG['uri_notification']
      i.Valores { |v| v.Valor(args[:value], :moeda => "BRL") }
      i.FormasPagamento { |p|
        p.FormaPagamento "CartaoCredito"
      }
    end
  end
end
