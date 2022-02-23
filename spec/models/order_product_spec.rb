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
require 'rails_helper'

RSpec.describe OrderProduct, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:order) }
    it { is_expected.to belong_to(:product) }
  end
  describe "validations" do
    it { is_expected.to validate_length_of(:observation).is_at_most(150) }
    it { is_expected.to validate_numericality_of(:quantity).is_greater_than(0) }
    it { is_expected.to validate_presence_of(:product_id) } 

  end
end
