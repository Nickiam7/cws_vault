class Wine < ApplicationRecord
  mount_uploader :image, BottleUploader

end
