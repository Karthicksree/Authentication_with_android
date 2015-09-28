class Post < ActiveRecord::Base
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :mediums, dependent: :destroy
  accepts_nested_attributes_for :comments
  accepts_nested_attributes_for :mediums
end
