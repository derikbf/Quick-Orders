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
FactoryBot.define do
  factory :order do
    client_name { "MyString" }
    table { 1 }
    user
    status { :finished }
  end
end
