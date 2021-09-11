class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  validates :name, :description, presence: true

  scope :wines, -> {where(product_type: 'wine')}

  after_create do
    stripe_product = Stripe::Product.create(name: name)
    stripe_price = Stripe::Price.create(product: stripe_product.id, unit_amount: self.price, currency: 'usd')
    update(stripe_product_id: stripe_product.id, stripe_price_id: stripe_price.id)
  end
end
