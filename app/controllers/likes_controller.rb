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
        like = Like.create(user_id:session[:user_id], restaurant_id:params[:like][:restaurant_id])
        flash[:notice] = "You now like #{like.restaurant.name}."
        redirect "/restaurants/#{like.restaurant.slug}"
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
      like = Helpers.current_user(session).likes.find_by(restaurant_id: params[:like][:restaurant_id])

      if Helpers.is_logged_in?(session) && like != nil
          like.destroy
          flash[:notice] = "You have unliked #{like.restaurant.name}."
          redirect "/users/#{Helpers.current_user(session).slug}"
      elsif Helpers.is_logged_in?(session) == false
          flash[:notice] = "You must login to UnLike restaurants"
          redirect '/sessions/login'
      elsif Helpers.is_logged_in?(session) && like == nil
          flash[:notice] = "You already don't like that restaurant."
          redirect "/users/#{Helpers.current_user(session).slug}"
      end
    end
  end