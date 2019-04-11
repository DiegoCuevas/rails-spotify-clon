module Admin
  class SongsController < ApplicationController
    def index
      @songs = Song.all
    end

    private

    def song_params
      params.require(:song).permit(:title, :duration, :rating, :progress)
    end
  end
end