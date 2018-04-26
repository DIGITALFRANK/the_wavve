
class Post < ActiveRecord::Base
    belongs_to :users

    has_many :poststags
    has_many :tags, through: :poststags

    has_many :postssubtags
    has_many :subtags, through: :postssubtags
end