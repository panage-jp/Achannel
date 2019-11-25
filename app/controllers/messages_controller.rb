class MessagesController < ApplicationController
  def create
    @message = Message.new(message_params)
    if @message.save 
      redirect_to room_path(params["message"][:room_id])
    end
  end

  def destroy
    message = Message.find(params[:id])
    message.content = "このレスは投稿者によって削除されました。"
    message.deleted_or_edited = 1
    if message.save
    
      redirect_to room_path(message.room.id)
    end
  end

  def update
    message = Message.find(params[:id])
    message.content = message_params[:content]
    message.deleted_or_edited = 2
    if message.save
      redirect_to room_path(message.room.id)
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

    def room_password_authenticate
    if params[:room][:password].to_i != Room.find(params[:id])[:password]
      redirect_to root_path
      flash[:notice] = "パスワードが間違っています"
    end
  end
end
