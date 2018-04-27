
######## TO DO

# 1 - user registration
# 2 - user create post (only while logged in) (remember post tags and subtags - maybe you should seed a few)
# 3 - post pages views and layouts






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



##################### APPLICATION ROUTES ######################

# landing
get '/' do
    @users = User.all

    erb :"users/index"
end 




# user login
# get '/sessions/login' do
#     erb :"sessions/login"
# end 

# post '/user/logged/in' do
#     erb :"users/home"
# end



# (C) create new users
get '/registration/signup' do
    erb :"registration/signup"
end 

post '/registration/new' do
    erb :"users/home"
end



# (C) create new posts
# get '/???' do
#     erb :"???"
# end 

# post '/???' do
#     erb :"???"
# end



# (R) read - user profile & posts feed - logout button
get '/sessions/login' do
    erb :"sessions/login"
end 

post '/user/logged/in' do
    @current_user = User.find_by(email: params[:email], password: params[:password])
    if @current_user != nil
        session[:id] = @current_user.id
        erb :"users/home"
    else   
        erb :"sessions/err_login"
    end
end

post '/user/logged/out' do
    session.clear
    redirect "/"
end



# (U) update post using a POST method form  => check erb file
get '/post/:id/edit' do 
    @post_id = params[:id]
    @post = Student.find(params[:id])
    erb :edit_post
end

put '/post/:id' do
    @post = Student.find(params[:id])
    @post.update(img_url: params[:img_url], text_content: params[:text_content])
end



# (D) Delete post
delete '/post/:id' do
    @post_id = params[:id]
    Post.destroy(@post_id)
end



