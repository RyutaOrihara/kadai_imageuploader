class BlogsController < ApplicationController
  before_action :require_login,only:[:new,:edit,:show,:destroy]
  before_action :set_blog,only:[:show,:edit,:update,:destroy]

  def current_user
    @current_user ||= User.find_by(id:session[:user_id])
  end


  def index
    @blogs = Blog.all
  end

  def create
    Blog.create(blog_params)
    redirect_to new_blog_path
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def show
  end

  def create
    @blog = Blog.new(blog_params)
    if @blog.save
      redirect_to blogs_path,notice: "ブログを作成しました！"
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    if @blog.update(blog_params)
      redirect_to blogs_path,notice:"ブログを編集しました！"
    else
      render 'edit'
    end
  end

  def destroy
  @blog.destroy
  redirect_to blogs_path,notice:"ブログを削除しました！"
  end

  def confirm
    @blog = Blog.new(blog_params)
    render :new if @blog.invalid?
  end

  private

  def blog_params
    params.require(:blog).permit(:title,:content)
  end

  def set_blog
    @blog = Blog.find(params[:id])
  end

  def require_login
    unless logged_in?
      flash[:error] = "ログインが必要です"
    redirect_to new_session_path
    end
  end
end
