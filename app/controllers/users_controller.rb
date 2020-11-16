# frozen_string_literal: true

class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new
  end

  def index
    @users = User.all
  end

  def followings
    @user = User.find(params[:id])
    @users = @user.followers.all
  end
end
