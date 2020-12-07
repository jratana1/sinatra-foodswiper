require 'sinatra/base'
require 'rack-flash'
class PhotosController < ApplicationController
  use Rack::Flash
  # GET: /photos
  get "/photos" do
    erb :"/photos/index.html"
  end

  # GET: /photos/new
  get "/photos/new" do
 
    @restaurants = Restaurant.all
    erb :"/photos/new.html"
  end

  # POST: /photos
  post "/photos" do
    if params[:photo][:url] == ""
      flash[:notice] = "You did not input a url!"
      erb :"/photos/new.html"
    end
    
    if params.key?("restaurant")  
      if params[:restaurant][:name] == ""
        flash[:notice] = "You did not input a restaurant name!"
        erb :"/photos/new.html"
      end
      restaurant = Restaurant.create(params[:restaurant])
    else
      restaurant = Restaurant.find(params[:photo][:restaurant_id])
    end
    
    restaurant.photos << Photo.create(params[:photo])
    flash[:notice] = "Photo/Restaurant has been added!"
    redirect "/restaurants/#{restaurant.slug}"
  end

  # GET: /photos/5
  get "/photos/:id" do
    erb :"/photos/show.html"
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
    redirect "/photos"
  end
end
