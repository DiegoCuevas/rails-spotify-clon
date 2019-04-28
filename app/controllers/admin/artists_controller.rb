module Admin
  class ArtistsController < ApplicationController

    def index
      @artists = Artist.all
    end

    def show
      @artist = Artist.find(params[:id])
    end  

    def new
      @artist = Artist.new
    end

    def create
      @artist = Artist.new(artist_params)
      if @artist.save
        redirect_to admin_artist_path(@artist), notice: "The artist was successfully created"
        $new_artists = [] unless defined? ($new_artists)
        $new_artists << @artist.id
      else
        render :new
      end
    end

    def edit
      @artist = Artist.find(params[:id])
    end
    
    def add_album
      artist = Artist.find(params[:artist_id])
      album = Album.find(params[:album_id])
      artist.albums << album
      if $new_artists.include?(params[:artist_id].to_i)

        UserMailer.send_request(artist)
        $new_artists.delete(params[:artist_id].to_i)
      end
      redirect_to edit_admin_artist_path(params[:artist_id])
    end

    def delete_album
      artist = Artist.find(params[:artist_id])
      album = Album.find(params[:album_id])
      artist.albums.delete(album)
      redirect_to edit_admin_artist_path(params[:artist_id])
    end

    def update
      @artist = Artist.find(params[:id])
      if @artist.update(artist_params)
        redirect_to admin_artist_path(@artist), notice: "The artist was successfully updated"
      else
        render :edit
      end
    end  

    def destroy
      artist = Artist.find(params[:id])
      artist.destroy
      redirect_to admin_artists_path, notice: "The artist was successfully deleted"
    end

    private
    def artist_params
      params.require(:artist).permit(
        :name,
        :age,
        :cover
      )
    end
  end
end