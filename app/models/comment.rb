class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :contribution
  has_many :replies
  acts_as_votable
  default_scope -> { order(created_at: :desc) }
    #validates :user_id, presence: true
    validates :contribution_id, presence: true
    validates :content, presence: true, length: { maximum: 140 }
end
