require 'sinatra/base'
require 'rack-flash'
class LikesController < ApplicationController
  use Rack::Flash
    # GET: /likes
    get "/likes" do
      erb :"/likes/index.html"
    end
  
    # GET: /likes/new
    get "/likes/new" do
      erb :"/likes/new.html"
    end
  
    # POST: /likes
    post "/likes" do
      
      Like.create(user_id:session[:user_id], restaurant_id:params[:like][:restaurant_id])
      restaurant = Restaurant.find(params[:like][:restaurant_id])
      flash[:notice] = "You now like #{restaurant.name}."
      redirect "/restaurants/#{restaurant.slug}"
    end
  
    # GET: /likes/5
    get "/likes/:id" do
      erb :"/likes/show.html"
    end
  
    # GET: /likes/5/edit
    get "/likes/:id/edit" do
      erb :"/likes/edit.html"
    end
  
    # PATCH: /likes/5
    patch "/likes/:id" do
      redirect "/likes/:id"
    end
  
    # DELETE: /likes/delete
    delete "/likes/delete" do
      restaurant = Restaurant.find(params[:like][:restaurant_id])
      Like.find_by(user_id: session[:user_id],restaurant_id:"#{restaurant.id}").destroy
      flash[:notice] = "You have unliked #{restaurant.name}."
      redirect "/restaurants/#{restaurant.slug}"
    end
  end