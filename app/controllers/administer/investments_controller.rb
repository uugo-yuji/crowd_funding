class Administer::InvestmentsController < ApplicationController
  before_action :administer_user

  def index
    @investments = Investment.all
  end

  private

  def administer_user
    redirect_to products_path if current_user.general?
  end
end
