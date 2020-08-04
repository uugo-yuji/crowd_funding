class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_product

  def create
    @like = current_user.likes.create(product_id: params[:product_id])
    redirect_back(fallback_location: product_path(@product))
  end

  def destroy
    @like = Like.find_by(product_id: params[:product_id], user_id: current_user.id)
    @like.destroy
    redirect_back(fallback_location: products_path)
  end

  private

  def set_product
    @product = Product.find(params[:id])
  end
end
