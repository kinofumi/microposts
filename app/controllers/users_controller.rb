class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update]

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "ユーザー情報を更新しました"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  private
  
  def set_user
    @user = User.find(params[:id])
    if User.find(params[:id]) != User.find(current_user)
      flash[:success] = "ログインしたユーザー以外の編集はできません"
      redirect_to @user
    end
  end
  
  def user_params
    params.require(:user).permit(:name, :email, :location, :password, :password_confirmation)
  end
end