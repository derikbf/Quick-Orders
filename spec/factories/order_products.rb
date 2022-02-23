# == Schema Information
#
# Table name: order_products
#
#  id          :bigint           not null, primary key
#  product_id  :bigint           not null
#  order_id    :bigint           not null
#  quantity    :integer
#  observation :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  price       :decimal(, )
#  total       :decimal(, )
#
FactoryBot.define do
  factory :order_products do
    order
    product
  end
end
