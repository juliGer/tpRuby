class UsersController < ApplicationController
  before_action :set_user
  def index
  end

  private

    def set_user
      @users = User.all
    end
end