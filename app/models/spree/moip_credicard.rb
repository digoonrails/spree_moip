module Spree
  class MoipCredicard < ActiveRecord::Base
    
    attr_accessor :number
    # has_one :payment, :as => :source
    # delegate :order, :to => :payment
    belongs_to :order

    attr_accessible :number, :month, :year, :verification_value, :first_name, :last_name, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip
    
    before_save :last_digits
    before_save :raise_
    
    def raise_
      p self
      # raise 'TESTE....'
    end
    
    def last_digits
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