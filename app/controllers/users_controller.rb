class UsersController < ApplicationController

  before_action :authorize, except: [:new, :create]

  def index
    render 'lists/index'
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      redirect_to user_lists_path(current_user)
    else
      render "new"
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])

    if @user.update(user_params)
      redirect_to user_lists_path(current_user)
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.delete

    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(
      :name,
      :email,
      :password,
      :password_confirmation
    )
  end
end
