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
        
    def edit
      @artist = Artist.find(params[:id])
    end

    def destroy
      artist = Artist.find(params[:id])
      artist.destroy
      redirect_to admin_artists_path, notice: "The artist was successfully deleted"
    end

    private

    def create
      @artist = Artist.new(artist_params)
      @artist.save
      redirect_to admin_artist_path(@artist), notice: "The artist was successfully created"
    end

    def update
      @artist = Artist.find(params[:id])
      if @artist.update(artist_params)
        redirect_to admin_artist_path(@artist), notice: "The artist was successfully updated"
      else
        render :edit
      end
    end  


    def artist_params
      params.require(:artist).permit(
        :name, 
        :age
      )
    end
  end
end