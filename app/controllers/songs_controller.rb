class SongsController < ApplicationController
  skip_before_action :authorization
  
  def index
    @songs = Song.all
  end

  def show
    @song = Song.find(params[:id])
  end

end
