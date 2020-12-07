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
      if Helpers.is_logged_in?(session) 
        Like.create(user_id:session[:user_id], restaurant_id:params[:like][:restaurant_id])
        restaurant = Restaurant.find(params[:like][:restaurant_id])
        flash[:notice] = "You now like #{restaurant.name}."
        redirect "/restaurants/#{restaurant.slug}"
      else
        flash[:notice] = "You must login to Like restaurants"
        redirect '/sessions/login'
      end
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
      if Helpers.is_logged_in?(session)
        restaurant = Restaurant.find(params[:like][:restaurant_id])
        like = Like.find_by(user_id: session[:user_id],restaurant_id:"#{restaurant.id}")
        if like != nil
          like.destroy
          flash[:notice] = "You have unliked #{restaurant.name}."
        else
          flash[:notice] = "You already don't like #{restaurant.name}."
        end
          redirect "/restaurants/#{restaurant.slug}"
      else
        flash[:notice] = "You must login to UnLike restaurants"
        redirect '/sessions/login'
      end
    end
  end