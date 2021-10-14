class Subject < ApplicationRecord
  has_many :tasks

  validates :name, uniqueness: true
end