class Profile < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_insensitive: true }
  has_many :users
end
