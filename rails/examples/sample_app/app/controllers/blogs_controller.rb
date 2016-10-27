class BlogsController < ApplicationController
  def new
    user = User.last
    @blog = user.blogs.build
  end

  def create
    Blog.create!(user_id: params[:blog][:user_id], content: params[:blog][:content])
  end

  def index
    @blogs = Blog.all
  end
end
