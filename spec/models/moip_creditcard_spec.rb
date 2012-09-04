require 'spec_helper'

describe Spree::MoipCreditcard do
  
  it { should have_valid_factory(:moip_creditcard) }
  
  context '#valid fields' do
  
    [:month, :year, :verification_value, :order_id, :cc_type, :number, :name_in_card, :phone, :born_at, :ident, :code_moip].each do |attr|
      it { should validate_presence_of attr  }
    end
    
    it "should have the 4 last digits" do
      moip_creditcard = FactoryGirl.create(:moip_creditcard, :number => '4984237031759934')
      moip_creditcard.last_digits.should eql('9934')
    end    
  end
  
  context '#nasp' do
    
    # 'pending', 'completed', 'failed', 'processing', 'checkout'
    
    let(:payment) { FactoryGirl.create(:payment_moip_creditcard) }
    let(:moip_creditcard) { FactoryGirl.create(:moip_creditcard, order_id: payment.order_id) }
    
    it "should be processing" do
      moip_creditcard.set_status_with('1')
      moip_creditcard.order.payments.first.state.should == 'processing'
      
      moip_creditcard.set_status_with('6')
      moip_creditcard.order.payments.first.state.should == 'processing'
    end
    
    it "should be pending" do
      moip_creditcard.set_status_with('2')
      moip_creditcard.order.payments.first.state.should == 'pending'
      
      moip_creditcard.set_status_with('3')
      moip_creditcard.order.payments.first.state.should == 'pending'
      
      moip_creditcard.set_status_with('7')
      moip_creditcard.order.payments.first.state.should == 'pending'
      
      moip_creditcard.set_status_with('8')
      moip_creditcard.order.payments.first.state.should == 'pending'
      
      moip_creditcard.set_status_with('9')
      moip_creditcard.order.payments.first.state.should == 'pending'
    end
    
    it "when status for 4, should be completed" do
      moip_creditcard.set_status_with('4')
      moip_creditcard.order.payments.first.state.should == 'completed'
    end
    
    it "when status for 5, should be failed" do
      moip_creditcard.set_status_with('5')
      moip_creditcard.order.payments.first.state.should == 'failed'
    end
    
  end
end