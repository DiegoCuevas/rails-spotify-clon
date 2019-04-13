module Api
  class AlbumsController < ApplicationController 
    def show
      render json: Album.find(params[:id])
    end
    def index
      render json: Album.all
    end 

    def search
      render json: Album.where(title: params[:title])
    end
    def rating
      album = Album.find(params[:id])
      album[:rating] = params[:rating]
      album.save
      render json: album   
    end
    def artist
      album = Album.find(params[:id])
      render json: album.artists
    end
    def song
      album = Album.find(params[:id])
      render json: album.songs
    end
    def update
      album.update(params[:id])
      render json: album.all
    end
  end
end