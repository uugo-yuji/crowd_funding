class MessageGroupsController < ApplicationController
  def index
    @message_groups = current_user.message_groups.order(created_at: :desc)
  end

  def show
    @message_group = MessageGroup.find(params[:id])
    @messages = @message_group.messages
    @message = Message.new
  end

  def create
    @message_group = MessageGroup.new(message_group_params)
    @message_group.users << current_user

    if @message_group.save!
      redirect_to message_group_url(@message_group)
    else
      redirect_to product_url(product)
    end
  end

  private

    def message_group_params
      params.permit(:product_id, user_ids: [])
    end
end
