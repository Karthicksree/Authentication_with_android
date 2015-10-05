# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  post_id    :integer
#

class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :post
  has_many :mediums, dependent: :destroy
  accepts_nested_attributes_for :mediums
end
