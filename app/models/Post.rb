
class Post < ActiveRecord::Base
    belongs_to :users
    has_many :posts_tags
    has_many :tags, through: :posts_tags
end