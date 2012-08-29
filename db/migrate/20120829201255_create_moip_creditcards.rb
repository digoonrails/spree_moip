class CreateMoipCreditcards < ActiveRecord::Migration
  def up
    create_table :spree_moip_creditcards do |t|
      t.integer :code_moip
      t.integer :order_id
      t.string :cc_type
      t.integer :month
      t.integer :year
      t.string :last_digits
      t.string :verification_value
      t.string :name_in_card
      t.string :phone
      t.string :ident
      t.date :born_at
      
      t.timestamps
    end
    add_index :spree_moip_creditcards, :code_moip
    add_index :spree_moip_creditcards, :order_id
  end
  
  def down
    drop_table :spree_moip_creditcards
  end
end
