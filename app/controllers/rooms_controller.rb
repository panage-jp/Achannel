class RoomsController < ApplicationController
  def index
    @room = Room.new
    @rooms =Room.all
  end
  def show
  end
end
