class RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms =Room.all
  end

  def show
  end

  def create
    @room = Room.create(room_params)
    # @message = Message.create(message_params)
  end

  private

  def room_params
    params.require(:room).permit(:title,:password)
  end

end
