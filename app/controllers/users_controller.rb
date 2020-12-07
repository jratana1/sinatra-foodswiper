require 'sinatra/base'
require 'rack-flash'
class UsersController < ApplicationController
  use Rack::Flash
  # GET: /users
  get "/users/friends" do
    #make a friends list
    erb :"/users/index"
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
    user = User.new(params[:user])  
    if user.save
      session[:user_id] = user.id
      redirect "/users/#{user.slug}"
    else  
      @error = user.errors.full_messages.join(" - ") #need to use flash[:notice]
      redirect "/signup"    
    end
  end
  
  get "/users/:slug" do
    #Restaurant.all.sort{|a, b| a.liking_users.count <=> b.liking_users.count}
    @user = User.find_by_slug(params[:slug])
    erb :'users/show'
  end

  get "/users/:slug/edit" do
    @user = User.find_by_slug(params[:slug])
    
    if Helpers.current_user(session).id = @user.id    
        erb :'users/edit'
    else
        redirect '/login'
    end
  end

  
  patch '/users/:slug' do
    user = User.find_by_slug(params[:slug])
 
    if user && user.authenticate(params[:password][:old_password])
      user.password = params[:password][:new_password]
      user.save
    else
      flash[:notice] = "Your password was incorrect!"
      redirect "/users/#{user.slug}/edit"
    end
    if params[:user].values.any? &:empty?
        redirect "/users/#{user.slug}/edit"
    end
    if Helpers.is_logged_in?(session) && user.id == session[:user_id]
        user.update(params[:user])
        redirect "/users/#{user.slug}"
    else
        redirect "/login"
    end
  end

end