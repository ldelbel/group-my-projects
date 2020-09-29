class SessionsController < ApplicationController
  include SessionsHelper
  def new
    @user = User.new
  end

  def create
    @user = User.find_by(name: params[:session][:name])
    if @user
      log_in @user
      redirect_back_or @user
      flash.now[:notice] = 'Logged in successfully!'
    elsif params[:session][:name].empty?
      flash[:alert] = 'Insert a name to log in.'
      render 'new'
    else
      flash[:alert] = 'This user doesn\'t exist.'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end
end
