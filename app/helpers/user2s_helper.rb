module User2sHelper
  def abc
    @user2 = User2.find(params[:id])
    WelcomeMailMailer.delete_mail(@user2).deliver_now
    if @user2.delete
      flash[:errors] = "User Deleted Successfully"
      redirect_to user2s_path
    else
      flash[:errors] = @user2.errors.full_messages
      redirect_to destroy_user2_path
    end
  end
end
