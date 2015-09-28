class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :mediums, dependent: :destroy
  accepts_nested_attributes_for :mediums
end
