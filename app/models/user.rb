class User < ApplicationRecord
  has_many :projects
  has_many :groups

  has_one_attached :avatar
end
