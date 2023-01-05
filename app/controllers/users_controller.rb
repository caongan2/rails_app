class UsersController < ApplicationController
  def new
  end

  def login

  end

  def accept
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to action: 'new'
    end
  end

  def create
    data_user[:password] = password_digest
    @user = User.new(data_user)
    if @user.save
      redirect_to action: 'login'
    else
      redirect_back(fallback_location: '')
    end
  end

  private
  def data_user
    params.permit(:email, :username, :password)
  end

  def password_digest
    params[:password]
  end
end
