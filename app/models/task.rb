class Task < ApplicationRecord
  has_and_belongs_to_many :tags
  belongs_to :subject, dependent: :destroy
  belongs_to :user, dependent: :destroy

  before_destroy { tags.destroy_all }


  accepts_nested_attributes_for :tags, allow_destroy: true,
                                reject_if: lambda {|attributes| attributes['kind'].blank?}
end