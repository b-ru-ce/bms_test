class Feedback < ActiveRecord::Base
end

# == Schema Information
#
# Table name: feedbacks
#
#  id         :integer          not null, primary key
#  name       :text
#  email      :text
#  phone      :text
#  theme      :text
#  text       :text
#  created_at :datetime
#  updated_at :datetime
#
