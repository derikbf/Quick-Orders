# == Schema Information
#
# Table name: orders
#
#  id          :bigint           not null, primary key
#  client_name :string
#  table       :integer
#  user_id     :bigint           not null
#  status      :integer          default("in_line")
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  total       :decimal(, )
#
require 'rails_helper'

RSpec.describe Order, type: :model do
  describe "associations" do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:order_products).inverse_of(:order)  }
    it { is_expected.to accept_nested_attributes_for(:order_products).allow_destroy(true) }
  end
  describe "validations" do
    it { is_expected.to validate_presence_of(:client_name) }
    it { is_expected.to validate_length_of(:client_name).is_at_most(40) }
    it { is_expected.to validate_presence_of(:table) }
    it { is_expected.to validate_numericality_of(:table).only_integer }
    it { is_expected.to define_enum_for(:status).with_values({ in_line: 0, preparing: 1, ready: 2, canceled: 3, finished: 4 }) }
    it { is_expected.to validate_presence_of(:status) }
  end
end
