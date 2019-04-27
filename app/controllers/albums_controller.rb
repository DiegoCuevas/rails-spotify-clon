class AlbumsController < ApplicationController
  skip_before_action :authorization
  
  def index
    @albums = Album.all
  end

  def show
    @album = Album.find(params[:id])
  end

  def rating
    @album = Album.find(params[:id])
    if !@album.ratings.where(user_id: current_user.id).any?
      @album.ratings.create(value: params[:rating], user_id: current_user.id)
      flash[:notice] = "Added to favorite albums" if params[:rating].to_i == 1
    else
      @rating = @album.ratings.where(user_id: current_user.id).first
      if @rating.value == params[:rating].to_i
        @rating.destroy
        flash[:notice] = "Remove from favorite albums" if params[:rating].to_i == 1
      else
        @rating.value = @rating.value * -1
        @rating.save
      end
    end
    redirect_to albums_path
  end
end
