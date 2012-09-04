Spree::Core::Engine.routes.draw do
  # Add your extension routes here
  namespace 'spree_moip' do
    get 'payments/nasp'
  end
end
