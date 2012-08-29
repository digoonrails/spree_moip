module Spree
  class MoipCreditcard < ActiveRecord::Base
    
    self.table_name = 'spree_moip_creditcards'
    
    attr_accessor :number
    
    belongs_to :order
    has_many :payments, :as => :source, :class_name => "Spree::Payment"

    attr_accessible :number, :month, :year, :verification_value, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip
    
    before_save :set_last_digits
    
    def set_last_digits
      self.last_digits = self.number.to_s[-4,4]
    end

    def actions
      %w{capture credit}
    end

    def capture(payment)
    end

    def can_capture?(payment)
    end

    def credit(payment, amount=nil)
    end

    def can_credit?(payment)
    end

    def process!(payment)
      puts "---------------- process! <<<<<<<<<<<<<<<<<<<<<<<<<<"
      # debugger
      p payment
      puts "---------------- process! <<<<<<<<<<<<<<<<<<<<<<<<<<"
      true
    end
  end
end