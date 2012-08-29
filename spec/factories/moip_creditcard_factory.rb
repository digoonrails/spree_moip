# encoding: utf-8
FactoryGirl.define do
  factory :moip_creditcard, :class => Spree::MoipCreditcard  do
    code_moip '123456'
    order_id '111'
    cc_type 'Vida'
    month '5'
    year '2015'
    last_digits '4987'
    verification_value '123'
    name_in_card 'NOME IGUAL CARTAO'
    phone '(18) 3643-9876'
    ident '219.999.999-99'
    born_at '22/12/1960'
  end
end