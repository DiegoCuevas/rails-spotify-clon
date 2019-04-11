module Admin
  class SongsController < ApplicationController
    def index
      @songs = Song.all
    end

    def show
      @song = Song.find(params[:id])
    end

    def new
      @song = Song.new
    end

    def create
      @song = Song.new(song_params)
      @song.save
      redirect_to admin_song_path(@song), notice: "The song was successfully created"
    end
    
    def edit
      @song = Song.find(params[:id])
    end

    def update
      @song = Song.find(params[:id])
      if @song.update(song_params)
        redirect_to admin_song_path(@song), notice: "The song was successfully updated"
      else
        render :edit
      end
    end

    def destroy
      song = Song.find(params[:id])
      song.destroy
      redirect_to admin_songs_path, notice: "The song was successfully deleted"
    end

    private

    def song_params
      params.require(:song).permit(:title, :duration, :rating, :progress)
    end
  end
end