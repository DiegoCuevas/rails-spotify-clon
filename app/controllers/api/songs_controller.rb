module Api
  class SongsController < ApplicationController

    skip_before_action :authorization

    def index
      render json: Song.all
    end

    def artists
      song = Song.find(params[:id])
      render json: song.artists
    end

    def albums
      song = Song.find(params[:id])
      render json: song.albums
    end

    def show
      render json: Song.find(params[:id])
    end

    def search
      render json: Song.where(title: params[:title])
    end

    def progress
      song = Song.find(params[:id])
      song[:progress] = params[:progress]
      song.save
      render json: song
    end

    def rating
      @rate = 1
      if params[:rating] == -1
        @rate = -1
      end
      song = Song.find(params[:id])
      if song.update(id: params[:id], rating: @rate)
        render json: song
      else
        render json: { message: "Error!" }, status: 500
      end
    end 
  end
end