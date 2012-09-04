# encoding: utf-8
FactoryGirl.define do
  
  factory :card_user do
    sequence(:name) { |n| "Cliente Sobrenome #{n}" }
    sequence(:email) { |n| "login#{n}@example.com" }
    id_pagador "1234556"
  end
  
  factory :card_address do
    address "Av. Brigadeiro Faria Lima"
    number "2927"
    comp "8. Andar"
    bairro "Jardim Paulistao"
    cidade "Sao Paulo"
    estado "SP"
    pais "BRA"
    cep "01452-000"
    telefone "(11)3165-4020"
  end
  
  factory :moip_payment_method, :class => Spree::PaymentMethod::Moip do   
    name 'Credit Card Moip'
    environment 'test'
    # active true
  end
  
  factory :payment_moip_creditcard, :class => Spree::Payment do
    amount 45.75
    payment_method { FactoryGirl.create(:moip_payment_method) }
    source { FactoryGirl.build(:moip_creditcard) }
    association(:order, :factory => :order)
    state 'pending'
    response_code '12345'
  end

end