class UsersController < ApplicationController
  before_action :set_user

  def show
  end

  # GET /users/1/export_all
  def export_all
    @books = @user.books
  end

  private

    def set_user
      @user = User.find(params[:user_id])
    end
end
