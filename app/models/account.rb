class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def vadmin?
    self.role == 'vadmin'
  end

  def retailer?
    self.role == 'retailer'
  end

  def customer?
    self.role == 'customer'
  end
end
