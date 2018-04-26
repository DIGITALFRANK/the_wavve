
class PostsSubTags < ActiveRecord::Base
    belongs_to :posts
    belongs_to :tags
    belongs_to :subtags
end