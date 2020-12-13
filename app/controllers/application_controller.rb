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
    if params.key?(:location)
      session[:location] = params[:location]
      results = YelpApiAdapter.search(params[:location])
      results.each do |restaurant|
          @rest_hash = Helpers.yelp_hash_converter(restaurant)
          if @rest_hash[:image_url]         
            restaurant = Restaurant.create_with(@rest_hash).find_or_create_by(yelp_id: @rest_hash[:yelp_id])
            restaurant.photos << Photo.create_with(url:restaurant.image_url,leftswipes:0,rightswipes:0).find_or_create_by(url: restaurant.image_url)
          end
      end
    else
      # session[:location]= "all"
    end
    
    
      if params[:swipe] == "Swipe Right"
        @swipe = "right"
        @photo = Photo.find(params[:photo][:id])
        @photo.rightswipes += 1
        @photo.save
        @restaurant = Restaurant.find(@photo.restaurant_id)
        Like.create(restaurant_id:@restaurant.id, user_id:session[:user_id])
        flash.now[:notice] = "You liked #{@restaurant.name}!"    
      elsif params[:swipe] == "Swipe Left"
        @photo = Photo.find(params[:photo][:id])
        @photo.leftswipes += 1
        @photo.save
        @photo = Photo.all.select {|photo| Helpers.slug_string(photo.restaurant.city) == Helpers.slug_string(session[:location])}.sample   
      else     
        @photo = Photo.all.select {|photo| Helpers.slug_string(photo.restaurant.city) == Helpers.slug_string(session[:location])}.sample       
      end  
      erb :"/swipe"
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
