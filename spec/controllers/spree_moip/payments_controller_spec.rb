require 'spec_helper'

describe SpreeMoip::PaymentsController do
    
  it "should respond success to 'post' nasp" do
        
    moip_creditcard = mock(Spree::MoipCreditcard, code_moip: 123456, order_id: 1,
                              cc_type: 'Visa', month: 5, year: 2015, number: '1234567812345678', 
                              verification_value: '123', name_in_card: 'NOME IGUAL CARTAO', 
                              phone: '(18) 3643-9876', ident: '219.999.999-99', born_at: '22/12/1960')

    Spree::MoipCreditcard.should_receive(:find_by_code_moip).with('123456').and_return(moip_creditcard)
    moip_creditcard.stub(:set_status_with).with('4').and_return(true)
    
    post :nasp, { status_pagamento: '4', cod_moip: '123456' }
    response.should render_template(:text => "OK")
  end
end
