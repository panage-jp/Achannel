class RoomsController < ApplicationController
  before_action :room_validation, only: [:update]
  before_action :room_password_authenticate, only: [:update,:destroy]
  
  def index
    @room = Room.new
    # @rooms =Room.all.order(id: "DESC")
    @rooms = Room.search_threads(params)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def serch
    @rooms = Room.search_threads(params)
    respond_to do |format|
      format.html
      format.json
    end
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
    @messages = @room.messages
  end

  def create
    @room = Room.create(room_params)
    @room_id = @room.id
    @message = Message.new(message_params)
    if @room.save && @message.save
      redirect_to root_path
    end
  end

  def destroy
    room = Room.find(params[:id])
    room.destroy
    redirect_to root_path
  end

  def update
    room = Room.find(params[:id])
    room.title = room_params[:title]
    if room.save
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
    client_ip = request.env["HTTP_X_FORWARDED_FOR"] || request.remote_ip
    client_id_num = client_ip.split(".").join()
    begin
      client_id_num.to_i
      srand(client_id_num)
      o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
      autho_id = (0...8).map { o[rand(o.length)] }.join
      return autho_id
    rescue
      return "???"
    end
  end

#スレッド編集、削除するときにパスワードがあっているかを確認
  def room_password_authenticate
    if params[:room][:password].to_i != Room.find(params[:id])[:password]
      flash[:notice] = "パスワードが間違っています"
      redirect_to root_path
    end
  end

  # スレッド編集時にタイトルが入力されているか。
  def room_validation
    if room_params[:title] == ""
      flash[:notice] = "タイトルを入力してください。"
      redirect_to root_path
    end
  end

end
