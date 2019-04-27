class ArtistsController < ApplicationController
  skip_before_action :authorization
  
  def index
    @artists = Artist.all
  end
  
  def show
    @artist = Artist.find(params[:id])
  end

end
