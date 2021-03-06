class MessagesController < ApplicationController
  before_action :message_validation, only: [:update,:create]
  before_action :message_password_authenticate,only: [:destroy,:update]
  
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
    params.require(:message).permit(:name,:password,:content,:responce).merge({autho_id: autho_id_generate, room_id: params["message"][:room_id]}).merge(client_ip: request.remote_ip.delete("."))
  end



#クライアントのipアドレスを取得し、投稿者のIDを生成
  def autho_id_generate
    client_ip = request.remote_ip
    client_id_num = client_ip.delete(".")
    client_id_num = client_id_num.to_i
    begin
      srand(client_id_num)
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      autho_id = (0...8).map { o[rand(o.length)] }.join
      return autho_id
    rescue
      return "???"
    end
  end

  # メッセージ編集、削除時にパスワードがあっているかを確認
  def message_password_authenticate
    if params[:message][:password].to_i != Message.find(params[:id])[:password]
      redirect_to room_path(Message.find(params[:id])[:room_id])
      flash[:notice] = "パスワードが間違っています"
    end
  end
# メッセージ編集、リプライ投稿じの内容のバリデーション
  def message_validation
    if message_params[:content] == ""
      flash[:notice] = "メッセージが入力されていません。"
      begin
        redirect_to room_path(params["message"][:room_id])
      rescue
        redirect_to room_path(Message.find(params[:id])[:room_id])
      end
      
    end
  end
end
