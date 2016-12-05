require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
enable :sessions

set :database, 'sqlite3:blog.sqlite3'
set :sessions, true

require './models'

get '/' do 
	erb :sign_in
end

get '/sign_in' do
	erb :sign_in
end

get '/profile' do
	@user = current_user
	erb :profile
end

get '/create_account' do
	erb :create_acct
end

get '/edit_acct' do
	erb :edit_acct
end

get '/new_post' do
	erb :new_post
end

get '/myAccount' do
	@user = current_user
	erb :myAccount
end

post '/create_account' do
	puts "these are the params: #{params.inspect}"
	@user = User.create(params)
	session[:user_id] = @user.id
	flash[:notice] = "You were successfully logged in!"
	erb :profile
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
    redirect '/profile' 
 else     
 	puts "no user was found"
 	flash[:alert] = "There was a problem signing you in."  
 	redirect '/sign_in' 
 end   
end

post '/sign_out' do
	session[:user_id] = nil
	redirect '/sign_in'
end

post '/post' do
	Post.create(message: params[:message], timecreated: Time.now)
end
