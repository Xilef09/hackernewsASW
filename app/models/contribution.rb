class Contribution < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :replies
    acts_as_votable
    #has_many :replies
    default_scope -> { order(created_at: :desc) }
    #validates :user_id, presence: true
    #validates :titulo, presence: true, length: { maximum: 140 }
end
