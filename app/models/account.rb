class Account < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  after_create do
    stripe_customer = Stripe::Customer.create(email: self.email)
    update(stripe_customer_id: stripe_customer.id)
  end

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
