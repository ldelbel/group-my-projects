class Group < ApplicationRecord
  validates :name, presence: true, length: { in: 4..18 }
  validates :name, uniqueness: true

  belongs_to :user
  has_many :groupings
  has_many :projects, through: :groupings, dependent: :destroy
  has_one_attached :icon
end
