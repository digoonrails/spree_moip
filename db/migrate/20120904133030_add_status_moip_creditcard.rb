class AddStatusMoipCreditcard < ActiveRecord::Migration
  def up
    add_column :spree_moip_creditcards, :status, :integer
  end

  def down
    remove_column :spree_moip_creditcards, :status
  end
end
