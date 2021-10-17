class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :task
  has_many :likes
end
