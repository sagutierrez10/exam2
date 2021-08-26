class UsersController < ApplicationController
  skip_before_action :require_login


  def index
  end

  def show
    @user = User.find(params[:id])
  end

  def login
    @user = User.find_by(email: user_params[:email])
    if @user && @user.authenticate(user_params[:password])
      session[:user_id] = @user.id
      redirect_to '/groups'
    else
      flash[:errors] = ['Wrong email or password']
      redirect_to :back
    end
  end

  def logout
    session.clear
    redirect_to '/main'
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to :back, notice: "You have successfully registered!"
    else
      flash[:errors] = @user.errors.full_messages
      redirect_to :back
    end
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:confirm_password)
  end


end
