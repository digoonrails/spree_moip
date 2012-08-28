module Spree
  class MoipMethod < PaymentMethod
    
    def method_type
      'moip_credicard'
    end
    
    # The class that will process payments for this payment type, used for @payment.source
    # e.g. Creditcard in the case of a the Gateway payment type
    # nil means the payment method doesn't require a source e.g. check
    def payment_source_class
      MoipCredicard
    end
    
    def payment_profiles_supported?
      false
    end
    
    def process_before_confirm?
      false
    end
    
    def source_required?
      false
    end
  end
end