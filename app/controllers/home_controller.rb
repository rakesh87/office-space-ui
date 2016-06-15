class HomeController < ApplicationController

  # before_action

  def index
    @spaces = ServerApi.new.office_spaces
  end

  def sign_up; end

  def register
    user_json = ServerApi.new.register(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]) 
    if user_json["errors"]
      @message = user_json["message"]
      render :sign_up
    else
      session[:user_id] = user_json['data']['id']
      redirect_to root_url
    end
  end

  def sign_in; end

  def login
    user_json = ServerApi.new.login(email: params[:email], password: params[:password]) 
    if user_json["errors"]
      @message = "email and password combination doesn't match"
      render :sign_in
    else
      session[:user_id] = user_json['data']['id']
      redirect_to root_url
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_url
  end

  def mark_work_spce_featured
    work_spce_id = params[:id]
    work_space = ServerApi.new.mark_work_space_featured(work_space_id: work_spce_id)
    if work_space['data'].present?
      @spaces = ServerApi.new.office_spaces
      render :index
    else
      redirect_to root_url
    end
  end

end
