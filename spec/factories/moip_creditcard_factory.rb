# encoding: utf-8
FactoryGirl.define do
  factory :moip_creditcard, :class => Spree::MoipCreditcard  do
    code_moip '123456'
    # order { FactoryGirl.create(:order) }
    association(:order, :factory => :order)
    cc_type 'Visa'
    month '5'
    year '2015'
    number '1234567812345678'
    verification_value '123'
    name_in_card 'NOME IGUAL CARTAO'
    phone '(18) 3643-9876'
    ident '219.999.999-99'
    born_at '22/12/1960'
  end
end