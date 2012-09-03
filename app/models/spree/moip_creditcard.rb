module Spree
  class MoipCreditcard < ActiveRecord::Base
    
    self.table_name = 'spree_moip_creditcards'
    
    attr_accessor :number
    
    belongs_to :order
    has_many :payments, :as => :source, :class_name => "Spree::Payment"

    attr_accessible :number, :month, :year, :verification_value, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip
    
    before_save :set_last_digits
    
    validates :month, :year, :verification_value, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip, :presence => true
    
    def set_last_digits
      self.last_digits = self.number.to_s[-4,4]
    end

    # Methods used by spree adm
    # def actions
    #   %w{capture credit}
    # end
    # 
    # def capture(payment)
    # end
    # 
    # def can_capture?(payment)
    # end
    # 
    # def credit(payment, amount=nil)
    # end
    # 
    # def can_credit?(payment)
    # end
    # 
    # def process!(payment)
    # end
  end
end