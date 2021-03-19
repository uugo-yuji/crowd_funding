class MessagesController < ApplicationController

  def sent
    message_group = MessageGroup.find(params[:message_group_id])
    @message = message_group.messages.new(message_params)
    @message.user = current_user

    if @message.save!
      redirect_to message_group_path(@message.message_group_id)
    else
      flash.now[:alert] = 'メッセージを入力してください。'
      redirect_to message_group_path(@message.message_group_id)
    end
  end

  private

    def message_params
      params.require(:message).permit(:content)
    end
end
