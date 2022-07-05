# typed: true

class BlogsController < ApplicationController
  def index
    blogs = Blog.all
    render json: blogs
  end

  def show
    blog = Blog.find(params[:id])
    render json: blog
  end

  def create
    blog = Blog.create(blog_params)
    render json: blog, status: :created
  end

  private

  def blog_params
    params.require(:blog).permit(:title, :contents)
  end
end
