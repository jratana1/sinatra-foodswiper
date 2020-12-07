require 'sinatra/base'
require 'rack-flash'
class RestaurantsController < ApplicationController
  use Rack::Flash
  # GET: /restaurants
  get "/restaurants" do
    @restaurants = Restaurant.all
    erb :"/restaurants/index.html"
  end

  get "/restaurants/:slug" do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    erb :"/restaurants/show.html"
  end

  get "/restaurants/:slug/edit" do
    erb :"/restaurants/edit.html"
  end

  patch "/restaurants/:slug" do
    redirect "/restaurants/:id"
  end

  delete "/restaurants/:slug/delete" do
    redirect "/restaurants"
  end
end
