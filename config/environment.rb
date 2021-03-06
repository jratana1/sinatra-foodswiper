ENV['SINATRA_ENV'] ||= "development"

require 'bundler/setup'
Bundler.require(:default, ENV['SINATRA_ENV'])
Dotenv.load if ENV['SINATRA_ENV'] == "development"

set :database_file, "./database.yml"

require './app/controllers/application_controller'
require_all 'app'
# Dotenv.load if ENV['SINATRA_ENV'] == "development"

# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])


# set :database_file, './database.yml'

# require './app/controllers/application_controller'
# require_all 'app'


# ENV['SINATRA_ENV'] ||= "development"

# require 'bundler/setup'
# Bundler.require(:default, ENV['SINATRA_ENV'])

# ActiveRecord::Base.establish_connection(
#   :adapter => "sqlite3",
#   :database => "db/#{ENV['SINATRA_ENV']}.sqlite"
# )

# require './app/controllers/application_controller'
# require_all 'app'