class RestaurantsController < ApplicationController

  # GET: /restaurants
  get "/restaurants" do
    @restaurants = Restaurant.all
    erb :"/restaurants/index.html"
  end

  # GET: /restaurants/new
  get "/restaurants/new" do
    erb :"/restaurants/new.html"
  end

  # POST: /restaurants
  post "/restaurants" do
    redirect "/restaurants"
  end

  get "/restaurants/:slug" do
    @restaurant = Restaurant.find_by_slug(params[:slug])
    erb :"/restaurants/show.html"
  end

  # GET: /restaurants/5/edit
  get "/restaurants/:id/edit" do
    erb :"/restaurants/edit.html"
  end

  # PATCH: /restaurants/5
  patch "/restaurants/:id" do
    redirect "/restaurants/:id"
  end

  # DELETE: /restaurants/5/delete
  delete "/restaurants/:id/delete" do
    redirect "/restaurants"
  end
end
