class Task < ApplicationRecord
  has_and_belongs_to_many :tags
  has_many :comments
  has_many_attached :images
  belongs_to :subject, dependent: :destroy
  belongs_to :user, dependent: :destroy

  before_destroy { tags.destroy_all }

  default_scope -> { order(created_at: :desc) }

  accepts_nested_attributes_for :tags, allow_destroy: true,
                                reject_if: lambda {|attributes| attributes['kind'].blank?}
end