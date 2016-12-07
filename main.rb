require 'sinatra'
require 'sinatra/activerecord'
require 'bundler/setup'
require 'sinatra/flash'
enable :sessions

set :database, 'sqlite3:blog.sqlite3'
set :sessions, true

require './models'

get '/' do 
	session[:user_id] = nil
	erb :sign_in
end

get '/sign_in' do
	erb :sign_in
end

get '/profile' do
	@user = current_user
	@posts = @user.posts.order(timecreated: :desc).limit(10)
	erb :profile
end

get '/create_account' do
	session[:user_id] = nil
	erb :create_acct
end

get '/edit_acct' do
	@user = current_user
	erb :edit_acct
end

get '/new_post' do
	@posts = current_user.posts
	erb :new_post
end

get '/myAccount' do
	@user = current_user
	erb :myAccount
end

get '/users/:id' do
	@user = User.find(params[:id])
	@posts = @user.posts.order(timecreated: :desc).limit(10)
	erb :users
end

get '/all_users' do
	@users = User.all
	erb :all_users
end

post '/create_account' do
	puts "these are the params: #{params.inspect}"
	if User.where(email: params[:email]).first
		puts "There was a user with that"
		flash[:alert] = "Email Already In Use" 
		redirect '/create_account'
	else
		@user = User.create(params)
		session[:user_id] = @user.id
		puts "there was not a user with that"
		flash[:alert] = "Valid Email" 
		redirect '/profile' 
	end 
end

post '/sign_in' do
	@user = User.where(email: params[:email]).first 
	if @user && @user.password == params[:password]   
		session[:user_id] = @user.id    
		redirect '/profile' 
	else     
		flash[:alert] = "Invalid Email or Password"  
		redirect '/sign_in' 
	end   
end

post '/sign_out' do
	session[:user_id] = nil
	redirect '/sign_in'
end

post '/new_post' do
	Post.create(message: params[:message], timecreated: Time.now, user_id: current_user.id)
	redirect '/new_post'
end

post '/delete_accont' do
	current_user.delete
	session[:user_id] = nil
	redirect '/create_account'
end

post '/edit_info' do
	current_user.update_attributes(params)
	redirect '/edit_acct'
end

post '/edit_acct' do
	redirect '/edit_acct'
end

def current_user
	if session[:user_id]
		User.find(session[:user_id])
	end
end
