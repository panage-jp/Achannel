class RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms =Room.all.order(id: "DESC")
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages
  end

  def create
    binding.pry
    @room = Room.create(room_params)
    @room_id = @room.id
    @message = Message.new(message_params)
    if @room.save && @message.save
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:title,:password)
  end
  def message_params
    {content: params["room"][:first_message], author: params["room"][:author],room_id: @room_id, autho_id: autho_id_generate,password: params["room"][:password]}
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
