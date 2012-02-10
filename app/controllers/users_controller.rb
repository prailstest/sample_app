class UsersController < ApplicationController

  before_filter :signed_in_user, only: [:edit, :update, :index, :destroy]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_only, only: [:destroy]
  before_filter :anonymous_only, only: [:new, :create]

  def index 
    @users = User.paginate(page: params[:page])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show 
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile successfully updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy 
    @user = User.find(params[:id])
    if current_user?(@user) && current_user.admin?
      redirect_to root_path, flash: { error: "Unable to delete your own administrator account." }
    else
      @user.destroy
      redirect_to users_path, flash: { success: "User #{@user.name} destroyed." }
    end
  end


  private

  def signed_in_user
    unless signed_in?
      store_location
      redirect_to signin_path, notice: "Please sign in to access this page."
    end
  end

  def correct_user 
    @user = User.find(params[:id])
    redirect_to signin_path, flash: { error: "You don't have permission to change this." } unless current_user?(@user)
  end



end
