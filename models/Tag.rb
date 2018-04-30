
class Tag < ActiveRecord::Base
    has_many :subtags

    has_many :poststags
    has_many :posts, through: :poststags

    has_many :postssubtags
    has_many :subtags, through: :postssubtags    
end