class Product < ApplicationRecord
  mount_uploader :image, ProductImageUploader

  scope :wines, -> {where(product_type: 'wine')}
end
