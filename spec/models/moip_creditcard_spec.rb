require 'spec_helper'

describe Spree::MoipCreditcard do
  
  it { should have_valid_factory(:moip_creditcard) }
  
  context '#valid fields' do
  
    [:month, :year, :verification_value, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip].each do |attr|
      it { should validate_presence_of attr  }
    end
    
    it "should have last 4 digits" do
      # card_number = '4984237031754765'
      moip_creditcard = FactoryGirl.create(:moip_creditcard, :number => '4984237031759934')
      moip_creditcard.last_digits.should eql('9934')
    end
    
  end
  
end