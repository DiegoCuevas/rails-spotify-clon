module Api
  class ArtistsController < ApplicationController

    skip_before_action :authorization

    def index
      @artists = Artist.all
      render json: @artists 
    end
   
    def show
      @artists = Artist.find(params[:id])
      render json: @artists 
    end
    def songs
      @artist = Artist.find(params[:id])
      render json: @artist.songs
    end
    def albums
      @artist = Artist.find(params[:id])
      render json: @artist.albums
    end
    def search
    @artist = Artist.where(name: params[:name])
    render json: @artist
    end
  end
end