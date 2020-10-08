class Project < ApplicationRecord
  validates :name, presence: true, length: { in: 6..18 }
  validates :name, uniqueness: true

  belongs_to :user
  has_many :groupings, dependent: :destroy
  has_many :groups, through: :groupings, dependent: :destroy
end
