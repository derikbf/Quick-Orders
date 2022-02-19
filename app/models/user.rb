# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  email                  :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :string
#  last_sign_in_ip        :string
#  first_name             :string
#  last_name              :string
#  role                   :integer          not null
#  discarded_at           :datetime
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  validates :role, presence: true
  devise :database_authenticatable, :recoverable, :rememberable, :validatable

  def admin?
    role == 1
  end

  def cook?
    role == 2
  end

  def waiter?
    role == 3
  end

  def role_name
    return 'Admin' if role == 1
    return 'Cook' if role == 2
    return 'Waiter' if role == 3
  end

  def active?
    discarded_at.nil?
  end

  def destroy
    self.discarded_at = Time.now
    save
  end

  def activate!
    self.discarded_at = nil
    save
  end

  def active_for_authentication?
    super && active?
  end
end
