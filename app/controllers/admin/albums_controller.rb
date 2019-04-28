module Admin
  class AlbumsController < ApplicationController

    def index
      @albums = Album.all
    end

    def show
      @album = Album.find(params[:id])
    end

    def new
      @album = Album.new
    end

    def create
      @album = Album.new(album_params)
      if @album.save
        redirect_to admin_album_path(@album), notice: "The album was successfully created"
        $new_albums = [] unless defined?($new_albums)
        $new_albums << @album.id
      else
        render :new
      end
    end

    def edit
      @album = Album.find(params[:id])
    end

    def update
      @album = Album.find(params[:id])
      if @album.update(album_params)
        redirect_to admin_album_path(@album), notice: "The album was successfully updated"
      else
        render :edit
      end
    end

    def destroy
      album = Album.find(params[:id])
      album.destroy
      redirect_to admin_albums_path, notice: "The album was successfully deleted"
    end

    def add_song
      album = Album.find(params[:album_id])
      song = Song.find(params[:song_id])
      album.songs << song
      p $new_albums
      p params[:album_id]

      if $new_albums.include?(params[:album_id].to_i)
        UserMailer.with(album: album).send_new_album.deliver_later
        $new_albums.delete(params[:album_id].to_i)
      end
      redirect_to edit_admin_album_path(params[:album_id])
    end

    def delete_song
      album = Album.find(params[:album_id])
      song = Song.find(params[:song_id])
      album.songs.delete(song)
      redirect_to edit_admin_album_path(params[:album_id])
    end

    private

    def album_params
      params.require(:album).permit(:title, :rating, :cover)
    end
  end
end
