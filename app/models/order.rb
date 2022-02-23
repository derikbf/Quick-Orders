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
class Order < ApplicationRecord
  validates :client_name, presence: true, length: { maximum: 40 }
  validates :table, presence: true,
                    numericality: { only_integer: true }
  enum status: { in_line: 0, preparing: 1, ready: 2, canceled: 3, finished: 4 }
  validates :status, presence: true

  belongs_to :user
  has_many :order_products, inverse_of: :order
  accepts_nested_attributes_for :order_products, allow_destroy: true

  before_save :set_total

  def status_name
    return I18n.t("activerecord.attributes.order.status_name.#{status}")
  end


  private

  def set_total
    self.total = 0
    self.order_products.each do |item|
      self.total += item.product.price * item.quantity
    end
  end
end
