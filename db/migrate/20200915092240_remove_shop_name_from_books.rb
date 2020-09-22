class RemoveShopNameFromBooks < ActiveRecord::Migration[5.2]
  def change
    remove_column :books, :shop_name, :text
    remove_column :books, :image_id, :string
    remove_column :books, :caption, :text
  end
end
