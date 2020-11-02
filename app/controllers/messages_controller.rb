class MessagesController < ApplicationController

  def sent
    message_group = MessageGroup.find(params[:message_group_id])
    @message = message_group.messages.new(message_params)
    # @message.message_group_id = params[:message][:message_group_id]

    if @message.save!
      redirect_to message_group_path(@message.message_group_id)
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      redirect_to message_group_path(@message.message_group_id)
    end
  end

  private

    def message_params
      params.require(:message).permit(:content).merge(user_id: current_user.id)
    end
end
