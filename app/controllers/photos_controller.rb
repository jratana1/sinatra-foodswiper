class PhotosController < ApplicationController

  # GET: /photos
  get "/photos" do
    erb :"/photos/index.html"
  end

  # GET: /photos/new
  get "/photos/new" do
    erb :"/photos/new.html"
  end

  # POST: /photos
  post "/photos" do
    redirect "/photos"
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
