require 'spec_helper'

describe 'Checkout' do
  let(:country) { create(:country, :name => 'Kangaland') }
  before do
    Factory(:state, :name => "Victoria", :country => country)
  end
  
  context "visitor makes checkout as guest without registration" do

    before(:each) do
      reset_spree_preferences do |config|
        config.allow_backorders = false
      end
      Spree::Product.delete_all
      @product = create(:product, :name => "RoR Mug")
      @product.on_hand = 1
      @product.save
      create(:zone)
    end
      
    context "when choosing moip payment", :js => true do
    
      before do
        Spree::PaymentMethod::Moip.create(:name => 'Credit Card Moip', environment: 'test')
        Spree::ShippingMethod.delete_all
        shipping_method = Factory(:shipping_method)
        calculator = Spree::Calculator::PerItem.create!({:calculable => shipping_method}, :without_protection => true)
        shipping_method.calculator = calculator
        shipping_method.save

        @product.shipping_category = shipping_method.shipping_category
        @product.save!
      end
    
      it "should payment completed successfully" do
        visit spree.root_path
        click_link "RoR Mug"
        click_button "add-to-cart-button"
        click_link "checkout-link"
        Spree::Order.last.update_column(:email, "ryan@spreecommerce.com")

        address = "order_bill_address_attributes"
        fill_in "#{address}_firstname", :with => "Ryan"
        fill_in "#{address}_lastname", :with => "Bigg"
        fill_in "#{address}_address1", :with => "143 Swan Street"
        fill_in "#{address}_city", :with => "Richmond"
        select "Kangaland", :from => "#{address}_country_id"
        select "Victoria", :from => "#{address}_state_id"
        fill_in "#{address}_zipcode", :with => "12345"
        fill_in "#{address}_phone", :with => "(555) 5555-555"

        check "Use Billing Address"
        click_button "Save and Continue"

        # Delivery
        click_button "Save and Continue"

        # Payment
        select 'Visa', :from => 'card_type'
        fill_in 'card_number', :with => '4984237031754765'
        select '5', :from => 'card_month'
        select "#{Time.now.year+5}", :from => 'card_year'
        fill_in 'card_code', :with => '123'
        fill_in 'phone', :with => '(18) 3642-0098'
        fill_in 'ident', :with => '210.665.900-00'
        fill_in 'born_at', :with => '28/12/2012'
        click_button "Save and Continue"
        
        page.should have_content('Your order has been processed successfully')
        page!
      end
    end
  
  end

  
end