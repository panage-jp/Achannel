class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save 
      redirect_to room_path(params["message"][:room_id])
    end
  end

  private
  def message_params
    params.require(:message).permit(:name,:password,:content,:responce).merge({autho_id: autho_id_generate, room_id: params["message"][:room_id]})
  end
#クライアントのipアドレスを取得し、投稿者のIDを生成
  def autho_id_generate
    client_ip = request.remote_ip
    client_id_num = client_ip.ord
    srand(client_id_num)
    o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
    autho_id = (0...8).map { o[rand(o.length)] }.join
  end
end
