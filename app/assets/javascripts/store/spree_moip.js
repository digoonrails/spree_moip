//= require store/spree_core

(function($){
  
  payment_success = function(data) {
    $('#code_moip').attr('value', data.CodigoMoIP)
    $('#checkout_form_payment').submit();
  }

  payment_fail = function(data) {
    if(data.length) {
      alert('Falha \n\n ' + data[0].Mensagem); 
    } else if(data){
      alert('Falha \n\n ' + data.Mensagem); 
    }
  }
  
  process_payemnt = function() {
    var settings = {
        "Forma": "CartaoCredito",
        "Instituicao": $('#card_type').val(),
        "Parcelas": "1",
        "Recebimento": "AVista",
        "CartaoCredito": {
            "Numero": $('#card_number').val(),
            "Expiracao": $("#card_month").val() + '/' +  $('#card_year').val(),
            "CodigoSeguranca": $('#card_code').val(),
            "Portador": {
                "Nome": $('#name_in_card').val(),
                "DataNascimento": $('#born_at').val(),
                "Telefone": $('#phone').val(),
                "Identidade": $('#ident').val()
            }
        }
    }
    MoipWidget(settings);
  }
  
  $(document).ready(function(){
    
    // Se achou o button #post-final 
    $('#checkout_form_payment .button').click(function(){
      
      // TODO: pegar todos os dados do cartão de crédito e adicionar em um objeto.
      
      // TODO: Adicionar recurso para que usuário possa ver a página de confirmação, ou seja,
      // Só vai efetuar a compra quando for a última etapa.
      
      process_payemnt();
      return false;
    });

  });
})(jQuery);