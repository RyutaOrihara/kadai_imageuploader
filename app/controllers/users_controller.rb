class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to new_session_path(@user)
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    if current_user.present?
      @favorites_blogs = current_user.favorite_blogs
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :image, :image_cache)
  end
end
