module Spree
  class PaymentMethod::Moip < PaymentMethod    
    
    # The class that will process payments for this payment type, used for @payment.source
    # e.g. Creditcard in the case of a the Gateway payment type
    # nil means the payment method doesn't require a source e.g. check
    def payment_source_class
      MoipCreditcard
    end
    
    def payment_profiles_supported?
      false
    end
    
    def process_before_confirm?
      false
    end
    
    def method_type
      'moip_creditcard'
    end
    
    def source_required?
      false
    end
  end
end