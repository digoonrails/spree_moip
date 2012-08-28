# encoding: utf-8
FactoryGirl.define do
  
  factory :user do
    sequence(:name) { |n| "Cliente Sobrenome #{n}" }
    sequence(:email) { |n| "login#{n}@example.com" }
    :id_pagador "1234556"
  end
  
  factory :address do
    :address "Av. Brigadeiro Faria Lima"
    :number "2927"
    :comp "8. Andar"
    :bairro "Jardim Paulistao"
    :cidade "Sao Paulo"
    :estado "SP"
    :pais "BRA"
    :cep "01452-000"
    :telefone "(11)3165-4020"
  end
end