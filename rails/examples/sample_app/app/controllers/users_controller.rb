class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    User.create!(name: params[:user][:name], email: params[:user][:email])
  end

  def index
    @users = User.all
  end

end
