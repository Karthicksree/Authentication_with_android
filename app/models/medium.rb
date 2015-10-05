# == Schema Information
#
# Table name: media
#
#  id                      :integer          not null, primary key
#  attachment_file_name    :string
#  attachment_content_type :string
#  attachment_file_size    :integer
#  attachment_updated_at   :datetime
#  post_id                 :integer
#  comment_id              :integer
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#

class Medium < ActiveRecord::Base
  belongs_to :post
  belongs_to :comment

  has_attached_file :attachment, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :attachment, content_type: /\Aimage\/.*\Z/
end
