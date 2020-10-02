class Group < ApplicationRecord
  belongs_to :user
  has_many :groupings, dependent: :destroy
  has_many :projects, through: :groupings, dependent: :destroy

  has_one_attached :icon
end
