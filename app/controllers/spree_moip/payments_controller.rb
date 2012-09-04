class SpreeMoip::PaymentsController < ActionController::Base
  
  # POST /spree_moip/payments/nasp
  def nasp
    mc = Spree::MoipCreditcard.find_by_code_moip(params[:cod_moip])
    mc.set_status_with params[:status_pagamento] if mc
    
    render :text => 'OK'
  end
end