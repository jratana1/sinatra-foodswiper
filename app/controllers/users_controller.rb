class UsersController < ApplicationController

  # GET: /users
  get "/users" do
    erb :"/users/index.html"
  end

  get '/signup' do
    if Helpers.is_logged_in?(session)
        user = User.find(session[:user_id])
        redirect "/users/#{user.slug}"
    else
        erb :"users/new"
    end
  end
  
  post "/signup" do 
    user = User.new(:username => params[:username], :password => params[:password], :email => params[:email])
  
    if params[:username] == "" || params[:password] == "" || params[:email] == ""
        redirect "/signup"
    else  
        user.save
        session[:user_id] = user.id
        redirect "/users/#{user.slug}"
    end
  end
  
  get "/users/:slug" do
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

end