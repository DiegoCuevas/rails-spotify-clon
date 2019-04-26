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

    private

    def album_params
      params.require(:album).permit(:title, :rating, :cover)
    end
  end
end
