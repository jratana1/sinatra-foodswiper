require './config/environment'

class ApplicationController < Sinatra::Base

 
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
    erb :swipe
  end

  get '/login' do
    if Helpers.is_logged_in?(session)
      user = User.find(session[:user_id])
        redirect "/users/#{user.slug}"
    else
        erb :"sessions/login"
    end
  end
  
  post "/login" do
    user = User.find_by(:name => params[:username])
        if user && user.authenticate(params[:password])
            session[:user_id] = user.id
            redirect "/users/#{user.slug}"
        else
            redirect "/login"
        end
  end

  get "/logout" do
    session.clear
    redirect "/login"
  end
end
