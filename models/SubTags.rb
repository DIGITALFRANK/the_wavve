

class SubTag < ActiveRecord::Base
    has_one :tag

    has_many :postssubtags
    has_many :posts, through: :postssubtags    
end