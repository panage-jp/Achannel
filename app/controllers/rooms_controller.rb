class RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms =Room.all
  end

  def show
    @room = Room.find(params[:id])
    @message = Message.new
  end

  def create
    @room = Room.new(room_params)
    # @message = Message.create(message_params)
    if @room.save
      redirect_to root_path
    end
  end

  private

  def room_params
    params.require(:room).permit(:title,:password)
  end

end
