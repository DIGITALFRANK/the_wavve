
require 'sinatra'
require 'sinatra/activerecord'

# models
require_relative '../models/user'
require_relative '../models/post'
require_relative '../models/tag'
require_relative '../models/poststags'



# the database
set :database, {adapter: 'postgresql', database: 'the_wavve'}


# live sessions with shotgun, and set explicit views folder
configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :views, "./views"
end


# routes
get '/' do
    erb :"users/index"
end 