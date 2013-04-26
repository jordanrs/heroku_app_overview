require 'rubygems'  
require 'sinatra'  
require 'Haml'
require 'httparty'
require 'json'

use Rack::Auth::Basic, "Restricted Area" do |username, password|
  username == 'admin' and password == ENV['APP_PASSWORD']
end

get '/' do  
  @apps = heroku_api('apps')
  sort_apps(@apps)
  
  erb :index
end

get '/app_info/:app_name' do
  app_name = params[:app_name]
  @colabs = heroku_api("apps/#{app_name}/collaborators")
  @addons = heroku_api("apps/#{app_name}/addons")
  erb :app_info
end

def heroku_api(endpoint)
  auth = {:username => "", :password => ENV['HEROKU_API_KEY']}
  response = HTTParty.get("https://api.heroku.com/#{endpoint}", :basic_auth => auth)
  JSON.parse(response.body)
end

def sort_apps(apps)
  apps.sort! do |x, y|
    x['name'] <=> y['name']
  end
end
  