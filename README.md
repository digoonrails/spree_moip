SpreeMoip
=========

Make payments with MoIP.


Install
=======

This gem depends of the spree 1.1.3

Gemfile

    gem 'spree', '1.1.3'
    gem 'spree_moip', :git => 'git@github.com:digoonrails/spree_moip.git'

after

    rails g spree_moip:install
    
Create file **config/gateway.yml**

    # you can find your token and api in 
    # https://desenvolvedor.moip.com.br/sandbox/AdmAPI.do?method=keys
    development:
        uri: https://desenvolvedor.moip.com.br/sandbox
        token: XXX
        key: XXX

    test:
        uri: https://desenvolvedor.moip.com.br/sandbox
        token: XXX
        key: XXX


Testing
-------

Be sure to bundle your dependencies and then create a dummy test app for the specs to run against.

    $ bundle
    $ bundle exec rake test_app
    $ bundle exec rspec spec

Copyright (c) 2012 [name of extension creator], released under the New BSD License
