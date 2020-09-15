class Administer::InvestmentsController < ApplicationController
  before_action :admin_user

  def index
    @investments = Investment.all
  end

  private

  def admin_user
    @user = current_user
    if @user.general?
      redirect_to products_path
    end
  end
end
