
######## TO DO

# 1 - create double nested layout for when users are logged in - connectivity available, but focus on articles => maybe give user the option of closing connections panel
# 2 - implement bootstrap for layout and responsiveness
# 3 - user create post (only while logged in) (remember post tags and subtags - maybe you should seed a few)
# 4 - user home page / post pages views and layouts - make sure you can list posts and users based on tags, subtags, and user industry => a given tag should belong to 1 industry, 1 industry has many tags => a subtag belongs to a 1 tag (which already belongs to 1 industry), 1 tag can have many subtags

        # a - you can pull & list all users => User.all
        # b - you can pull & list users by their industry => industry_users.all
        # c - you can pull & list all posts => Posts.all
        # d - you can pull & list posts by user => Users.posts
        # d - you can pull & list posts by the tag => Tag.posts
        # e - you can pull & list posts by the subtag => Subtag.posts
        # f - users can search tags and users by keyword (tag, subtag, and user name to start)



# 5 - pretty it up - scss for layouts, theme etc... responsivness  => are you using a framework? you should for good practice

# lastly - form validation






require 'sinatra'
require 'sinatra/activerecord'

# models
require_relative './models/user'
require_relative './models/post'
require_relative './models/tag'
require_relative './models/poststags'
require_relative './models/subtags'
require_relative './models/postssubtags'



# the database
# set :database, {adapter: 'postgresql', database: 'the_wavve'}


# live sessions with shotgun, and set explicit views folder, make stylesheet static
configure do
    enable :sessions unless test?
    set :session_secret, "secret"
    set :views, "./views"
    set :public_folder, "./public"
end
# Proc.new { 'source.css'.join(root, "static") }


# make all users available globally
@users = User.all



##################### APPLICATION ROUTES ######################




class App < Sinatra::Base


    configure do
        set :session_secret, "secret"
        set :views, "./views"
        set :public_folder, "./public"
    end


    # landing
    get '/' do
        # make all users available globally
        @users = User.all
        @design_users = User.where("industry = 'design'")
        @tech_users = User.where("industry = 'tech'")
        @advertising_users = User.where(["industry = :industry", { industry: "Advertising" }])

        # puts '***********'
        # puts @advertising_users.inspect.inspect
        # puts '$$$$$$$$'

        # @users.each do |user| 
        #     puts user.first_name    
        # end 

        # @advertising_users.each do |user| 
        #     puts user.first_name  
        #     puts user.last_name  
        #     puts user.email  
        # end 


        if session[:id] != nil
            erb :"users/home"
        else
            erb :"users/index"
        end
    end 


    
    # users

    get '/home' do
        # make all users available globally
        @users = User.all

        @current_user = User.find_by(id: session[:id])
        if @current_user != nil
            # session[:id] = @current_user.id

                erb :loggedin_layout do
                erb :"users/home"
                end


            # erb :"users/home"
        else   
            erb :"sessions/login"
        end
    end 

    get '/profile' do
        # make all users available globally
        @users = User.all
        
        @current_user = User.find_by(id: session[:id])
        if @current_user != nil
            # session[:id] = @current_user.id

                erb :loggedin_layout do
                erb :"users/profile"
                end


            # erb :"users/home"
        else   
            erb :"sessions/login"
        end
    end 

    delete '/users/:id' do |id|
        @user_id = params[:id]
        User.destroy(@user_id)
        redirect "sessions/login"
    end

    get '/your_wavve' do
        # make all users available globally
        @users = User.all
        
        @current_user = User.find_by(id: session[:id])
        @user_posts = Post.where(:user_id => @current_user.id)
        if @current_user != nil
            # session[:id] = @current_user.id

                erb :loggedin_layout do
                erb :"users/your_wavve"
                end


            # erb :"users/home"
        else   
            erb :"sessions/login"
        end
    end 

    get '/the_wavve/:id' do
        # make all users available globally
        @users = User.all
        
        @current_user = User.find_by(id: session[:id])
        @other_user = User.find_by(id: params[:id])
        
        @other_user_posts = Post.where(:user_id => params[:id])
        if @current_user != nil
            # session[:id] = @current_user.id

                erb :loggedin_layout do
                erb :"users/the_wavve"
                end


            # erb :"users/home"
        else   
            erb :"sessions/login"
        end
    end 




    # (C) create new users
    get '/registration/signup' do
        erb :"registration/signup"
    end 

    post '/registration/new' do
        # make all users available globally
        @users = User.all
        
        if params[:first_name] && params[:last_name] && params[:industry] && params[:title] && params[:email] && params[:password] != ''
            User.create(first_name: params[:first_name], last_name: params[:last_name], industry: params[:industry], title: params[:title], email: params[:email], password: params[:password])
            @current_user = User.find_by(email: params[:email], password: params[:password])
            if @current_user != nil
                session[:id] = @current_user.id
                erb :loggedin_layout do
                    erb :"users/home"
                end
            else   
                erb :"registration/signup"
            end
        else
            erb :"registration/signup"
        end
    end



    # (R) read - user profile & posts feed - logout button
    get '/sessions/login' do
        erb :"sessions/login"
    end 

    post '/user/logged/in' do
        # make all users available globally
        @users = User.all
        

        @current_user = User.find_by(email: params[:email], password: params[:password])
        if @current_user != nil
            session[:id] = @current_user.id

                erb :loggedin_layout do
                erb :"users/home"
                end


            # erb :"users/home"
        else   
            erb :"sessions/login"
        end
    end

    post '/user/logged/out' do
        session.clear
        redirect "/"
    end





    # (R) read specific post

    get '/posts/:id' do 
        @post = Post.find(params[:id])
        erb :"posts/post"
    end




    # (C) create new posts

    post '/post/new' do
        # make all users available globally
        @users = User.all
        

        @post = Post.create(img_url: params[:img_url], title: params[:title], subtitle: params[:subtitle], text_content: params[:text_content], user_id: session[:id])
        
        puts session[:id]

        erb :loggedin_layout do
            erb :"posts/post"
        end

        # redirect "posts/#{@post.id}"
        redirect "/your_wavve"
    end




    # (U) update post using a POST method form  => check erb file
    get '/post/:id/edit' do 
        @post_id = params[:id]
        @post = Post.find(params[:id])
        erb :edit_post
    end

    put '/post/:id' do
        @post = Post.find(params[:id])
        @post.update(img_url: params[:img_url], text_content: params[:text_content])
    end



    # (D) Delete post
    delete '/post/:id' do
        @post_id = params[:id]
        Post.destroy(@post_id)
    end



end

