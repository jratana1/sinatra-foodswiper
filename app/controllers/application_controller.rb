require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base
  use Rack::Flash
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :welcome
  end

  get "/swipe" do
      
    if params.key?("photo")
      @swipe = "right"
      @photo = Photo.find(params[:photo][:id])
      
      @restaurant = Restaurant.find(@photo.restaurant_id)
      flash.now[:notice] = "You liked #{@restaurant.name}!"
      erb :"/swipe"
    else
      @swipe = "left"
      rand_num= rand(1..Photo.all.size)
      @photo = Photo.find(rand_num)
      erb :"/swipe"
    end  
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      user = User.find(session[:user_id])
      flash[:notice] = "You are already logged in!"
        redirect "/users/#{user.slug}"
    else
        erb :"sessions/login"
    end
  end
  
  post "/login" do
    user = User.find_by(:name => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            flash[:notice] = "You have successfully logged in!"
            redirect "/users/#{user.slug}"
        else
            flash[:notice] = "Login was incorrect!"
            redirect "/login"
        end
  end

  get "/logout" do
    session.clear
    flash[:notice] = "Logout complete.  Goodbye!"
    redirect "/login"
  end
end
