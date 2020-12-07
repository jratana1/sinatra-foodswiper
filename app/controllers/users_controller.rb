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
        flash[:notice] = "You are already logged in!"
        redirect "/users/#{user.slug}"
    else
        erb :"users/new"
    end
  end
  
  post "/signup" do 
    user = User.new(params[:user])  
    if user.save
      session[:user_id] = user.id
      flash[:notice] = "Welcome, you have successfully signed up!"
      redirect "/users/#{user.slug}"
    else  
      flash[:notice] = "You must enter a password, username, and email!"
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
      flash[:notice] = "Username or email was blank!"
        redirect "/users/#{user.slug}/edit"
    end
    if Helpers.is_logged_in?(session) && user.id == session[:user_id]
        user.update(params[:user])
        flash[:notice] = "Your profile has been updated!"
        redirect "/users/#{user.slug}"
    else
        flash[:notice] = "You are not logged in!"
        redirect "/login"
    end
  end

  delete '/users/:slug/delete' do
    User.find(session[:user_id]).destroy
    session.clear
    flash[:notice] = "Your account has been deleted!"
    redirect "/users/new"
  end
end