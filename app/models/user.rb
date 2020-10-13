class User < ApplicationRecord
  validates :name, presence: true, length: { in: 5..20 }
  validates :name, uniqueness: true

  has_many :projects, dependent: :destroy
  has_many :groups, dependent: :destroy
  has_one_attached :avatar
end
