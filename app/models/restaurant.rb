class Restaurant < ApplicationRecord
  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_city_name?
  has_many :foods, dependent: :destroy
  belongs_to :user
  validates :name, presence: true
  validates :address, presence: true
  validates :photo, presence: true

end
