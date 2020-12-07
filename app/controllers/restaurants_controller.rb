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
    redirect "/restaurants/<%=@restaurant.slug%>"
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
