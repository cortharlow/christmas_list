class ListsController < ApplicationController

  before_action :authorize

  def index
    @user = User.find(params[:user_id])
    @list = @user.lists.all
  end

  def new
    @list = List.new
  end

  def create
    user = current_user
    @list = List.new(list_params)
    user.lists.push(@list)

    if @list.save
      redirect_to user_lists_path(current_user)
    else
      render "new"
    end
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])

    if @list.update(list_params)
      redirect_to user_lists_path(current_user)
    else
      render "edit"
    end
  end

  def destroy
    @list = List.find_by_id(params[:id])

    if @list.present?
      @list.destroy
    end

    redirect_to user_lists_path
  end

  private

  def list_params
    params.require(:list).permit(
      :name,
      :description,
      :url,
      :price
    )
  end
end
