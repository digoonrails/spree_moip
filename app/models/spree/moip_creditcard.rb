class Spree::MoipCreditcard < ActiveRecord::Base
  
  self.table_name = 'spree_moip_creditcards'
  
  attr_accessor :number
  
  belongs_to :order
  has_many :payments, :as => :source, :class_name => "Spree::Payment"

  attr_accessible :number, :month, :year, :verification_value, :order_id, :cc_type, :last_digits, :name_in_card, :phone, :born_at, :ident, :code_moip
  
  before_save :set_last_digits
  
  validates :month, :year, :verification_value, :order_id, :cc_type, :name_in_card, :phone, :born_at, :ident, :code_moip, :number, :presence => true
  
  
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
  
  def set_status_with(status)
    self.status = status
    self.save!
    
    self.set_state_payments_by_moip_status(status)
    self.order.payments.reload
    self.order.update!
  end
  
  protected
    def set_state_payments_by_moip_status(status)
      case status.to_i
      when 4      then self.order.payments.update_all :state => 'completed'
      when 5      then self.order.payments.update_all :state => 'failed'
      when 1, 6   then self.order.payments.update_all :state => 'processing'
      else 
        self.order.payments.update_all :state => 'pending'
      end
    end
end


#http://labs.moip.com.br/forum/showthread.php?4-Como-funciona-o-NASP-%28Notifica%E7%E3o-de-Altera%E7%E3o-de-Status-de-Pagamento%29
# 1 | autorizado      | Pagamento já foi realizado porém ainda não foi creditado na Carteira MoIP recebedora (devido ao floating da forma de pagamento)
# 2 | iniciado        | Pagamento está sendo realizado ou janela do navegador foi fechada (pagamento abandonado)
# 3 | boleto impresso | Boleto foi impresso e ainda não foi pago
# 4 | concluido       | Pagamento já foi realizado e dinheiro já foi creditado na Carteira MoIP recebedora
# 5 | cancelado       | Pagamento foi cancelado pelo pagador, instituição de pagamento, MoIP ou recebedor antes de ser concluído
# 6 | em análise      | Pagamento foi realizado com cartão de crédito e autorizado, porém está em análise pela Equipe MoIP. Não existe garantia de que será concluído
# 7 | estornado       | Pagamento foi estornado pelo pagador, recebedor, instituição de pagamento ou MoIP
# 8 | em revisão      | Pagamento está em revisão pela equipe de Disputa ou por Chargeback (Deprecated)
# 9 | reeembolsado    | Pagamento foi reembolsado diretamente para a carteira MoIP do pagador pelo recebedor do pagamento ou pelo MoIP