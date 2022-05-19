class User2sController < ApplicationController
  def index
    @user2s = User2.all
  end

  def new
    @user2 = User2.new
  end

  def create
    @user2 = User2.create(user2_params)
    if @user2.valid?
      EmailJob.set(wait: 5.seconds).perform_later(@user2)
      flash[:errors] = "User Created Successfully"
      redirect_to user2s_path
    else
      flash[:errors] = @user2.errors.full_messages
      redirect_to new_user2_path
    end
  end

  def show
    @user2 = User2.find(params[:id])
  end

  def edit
    @user2 = User2.find(params[:id])
  end

  def update
    @user2 = User2.find(params[:id])
    before_mail = @user2.email
    if @user2.update(user2_params)
      EmailJob.set(wait: 5.seconds).perform_later(@user2) if before_mail != @user2.email
      flash[:errors] = "User Updated Successfully"
      redirect_to user2_path(@user2)
    else
      flash[:errors] = @user2.errors.full_messages
      redirect_to edit_user2_path
    end
  end

  #  we can also define entire destroy method in helpers.
  def destroy
    abc
  end

  private

  def user2_params
    params.require(:user2).permit(:name, :email, :picture, :resume)
  end
end
