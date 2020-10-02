class Group < ApplicationRecord
  belongs_to :user
  has_many :groupings
  has_many :projects, through: :groupings

  has_one_attached :icon
end
