require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
enable :sessions

set :database, 'sqlite3:blog.sqlite3'
set :sessions, true

require './models'

get '/' do 
	erb :home
end

get '/create_acct' do
	erb :create_acct
end

get '/sign_in' do
	erb :sign_in
end

get '/settings' do
	erb :settings
end

get '/edit_acct' do
	erb :edit_acct
end

get '/new_post' do
	erb :new_post
end

get '/profile' do
	erb :profile
end

post '/create_account' do
	puts "these are the params: #{params.inspect}"
	@user = User.create(params)
	session[:user_id] = @user.id
	flash[:notice] = "You were successfully logged in!"
	erb :home
end

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end

post '/sign_in' do
@user = User.where(email: params[:email]).first 
  if @user && @user.password == params[:password]   
    session[:user_id] = @user.id    
    flash[:notice] = "You've been signed in successfully."  
 else     
 	puts "no user was found"
 	flash[:alert] = "There was a problem signing you in."   
 end   
 redirect '/'
end

post '/sign_out' do
	session[:user_id] = nil
	redirect '/sign_in'
end
