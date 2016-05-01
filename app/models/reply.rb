class Reply < ActiveRecord::Base
  belongs_to :user
  belongs_to :contribution
  belongs_to :comment
  acts_as_votable
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 140 }
end
