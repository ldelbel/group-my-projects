class Project < ApplicationRecord
  belongs_to :user
  has_many :groupings, dependent: :destroy
  has_many :groups, through: :groupings, dependent: :destroy
end
