class UsersController < ApplicationController

  skip_before_action :authorized, only: [:new, :login, :accept, :create, :password_digest, :data]
  def new
  end

  def logout
    session[:user_id] = nil
    redirect_to '/login'
  end
  def login

  end

  def accept
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to controller: 'posts', action: 'index'
    else
      redirect_to action: 'new'
    end
  end
  def create
    data[:password] = password_digest
    @user = User.new(data)
    if @user.save
      redirect_back(fallback_location: '')
    end
  end

  def password_digest
    params[:password]
  end
  def data
    params.permit(:email, :username, :password, :avatar)
  end
end
