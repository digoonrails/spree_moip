Spree::CheckoutController.class_eval do
  
  before_filter :get_moip_token, :only => :edit
  
  def get_moip_token
    if @order.payment?
      @moip_token = SpreeMoip::Moip.authorize({ :reason => "Pagamento", :id => "#{@order.number}-#{Time.now.strftime('%H%M%S')}", :value => @order.total })
    end
  end
  
end