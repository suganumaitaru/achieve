class ConversationsController < ApplicationController

    before_action :authenticate_user! #before_actionの使い型を確認

    def index
        @users = User.all
        @conversation = Conversation.all
    end

    def create
        if Conversation.between(params[:sender_id], params[:recipient_id]).present?
            @conversation = Conversation.between(params[:sender_id], params[:recipient_id]).first
        else
            @conversation = Conversation.create!(conversation_params)
        end

        redirect_to conversation_messages_path(@conversation)
    end
end


    private
        def conversation_params
            params.permit(:sender_id, :recipient_id)
        end
