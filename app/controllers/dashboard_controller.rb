class DashboardController < ApplicationController
  authorize_resource :class => false

  def index
    params[:q] ||= {}
    params[:q][:date_gteq] ||= Date.today
    params[:q][:date_lteq] ||= Date.today

    start_date = params[:q][:date_gteq].try(:to_date)
    end_date = params[:q][:date_lteq].try(:to_date)

    @order_quantity = load_order_products(start_date, end_date).count
    @total_renevue = load_order_products(start_date, end_date).includes(:product).sum(&:price)

    @users_orders = User.includes(:orders).group("users.first_name").pluck("users.first_name, count(orders.id)")

    @orders = Order.group(:status).count

  end

  private

  def load_order_products(start_date, end_date)
    order_products = OrderProduct.joins('INNER JOIN orders ON orders.id = order_products.order_id')
    order_products = order_products.where('orders.created_at >= ?', start_date.beginning_of_day) if start_date.present?
    order_products = order_products.where('orders.created_at <= ?', end_date.end_of_day) if end_date.present?
  end

  def load_orders(start_date, end_date)
    orders = Order.all
    orders = orders.where('created_at >= ?', start_date.beginning_of_day) if start_date.present?
    orders = orders.where('created_at <= ?', end_date.end_of_day) if end_date.present?
  end
end
