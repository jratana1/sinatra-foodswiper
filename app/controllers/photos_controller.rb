require 'sinatra/base'
require 'rack-flash'
class PhotosController < ApplicationController
  use Rack::Flash
  # GET: /photos
  get "/photos" do
    @user = User.find(session[:user_id])
    erb :"/photos/index.html"
  end

  # GET: /photos/new
  get "/photos/new" do
    if Helpers.is_logged_in?(session)
      @restaurants = Restaurant.all
      erb :"/photos/new.html"
    else
      flash[:notice] = "You must login to post photos"
      redirect '/sessions/login'
    end
  end

  # POST: /photos
    post "/photos" do
 
        if params[:photo][:url] == ""
          flash[:notice] = "You did not input a url!"
          erb :"/photos/new.html"
        elsif params.key?("restaurant")  && params[:restaurant][:name] == ""
            flash[:notice] = "You did not input a restaurant name!"
            erb :"/photos/new.html"
        elsif params.key?("restaurant")
            restaurant = Restaurant.create(params[:restaurant])
            photo = Photo.create(params[:photo])
            restaurant.photos << photo
            User.find(session[:user_id]).photos << photo
            flash[:notice] = "Photo/Restaurant has been added!"
            redirect "/restaurants/#{restaurant.slug}"
        else
          restaurant = Restaurant.find(params[:photo][:restaurant_id])
          photo = Photo.create(params[:photo])
          restaurant.photos << photo
          User.find(session[:user_id]).photos << photo
          flash[:notice] = "Photo/Restaurant has been added!"
          redirect "/restaurants/#{restaurant.slug}"
        end
      
  end

  # GET: /photos/5
  get "/photos/:id" do
    @photo = Photo.find(params[:id])
    if Helpers.current_user(session).id == @photo.user_id   
    erb :"/photos/show.html"
    else
      flash[:notice] = "You can only view and delete photos you posted"
      redirect '/photos'
    end
  end

  # GET: /photos/5/edit
  get "/photos/:id/edit" do
    erb :"/photos/edit.html"
  end

  # PATCH: /photos/5
  patch "/photos/:id" do
    redirect "/photos/:id"
  end

  # DELETE: /photos/5/delete
  delete "/photos/:id/delete" do
    @photo = Photo.find(params[:id])
    if Helpers.current_user(session).id == @photo.user_id   
      Photo.find(params[:id]).destroy
      flash[:notice] = "Your photo has been deleted!"
    else
      flash[:notice] = "You can only delete photos you posted!"
    end
    redirect "/photos"
  end
end
