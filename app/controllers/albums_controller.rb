class AlbumsController < ApplicationController
  skip_before_action :authorization
  
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end
end
