class AddPriceAndTotalToOrderProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :order_products, :price, :decimal
    add_column :order_products, :total, :decimal
  end
end
