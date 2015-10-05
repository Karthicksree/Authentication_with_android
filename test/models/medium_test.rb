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

require 'test_helper'

class MediumTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end
