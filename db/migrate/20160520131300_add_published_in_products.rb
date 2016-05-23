class AddPublishedInProducts < ActiveRecord::Migration
  def change
    add_column :spree_products, :published, :boolean, default: false
    add_column :spree_products, :published_at, :datetime
    add_column :spree_products, :publisher_id, :integer
  end
end
