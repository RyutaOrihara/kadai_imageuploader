class BlogsController < ApplicationController
  before_action :require_login,only:[:new,:edit,:show,:destroy]
  before_action :set_blog,only:[:show,:edit,:update,:destroy]
  before_action :require_login_current,only:[:edit]
  def index
    @blogs = Blog.all
  end

  def new
    if params[:back]
      @blog = Blog.new(blog_params)
    else
      @blog = Blog.new
    end
  end

  def show
    @favorite = current_user.favorites.find_by(blog_id: @blog.id)
  end

  def create
    @blog = Blog.new(blog_params)
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
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
    @blog.user_id = current_user.id #現在ログインしているuserのidを、blogのuser_idカラムに挿入する
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

  def require_login_current
    unless current_user.id  ==  @blog.user_id
      redirect_to blogs_path,notice:"その他のユーザーです！"
    end
  end
end
