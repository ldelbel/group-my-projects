class Project < ApplicationRecord
  belongs_to :user
  has_many :groupings
  has_many :groups, through: :groupings
end
