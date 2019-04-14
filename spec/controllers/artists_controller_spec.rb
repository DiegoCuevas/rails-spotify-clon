require 'rails_helper'

module Api
  describe ArtistsController do
    before do
      @artist = Artist.create(
        name: "Michael Cera",
        age: 30
      )
      @album = Album.create(
        title: "True that",
        rating: 1
      )
      @song = Song.create(
        title: "Oh Nadine",
        duration: 512,
        rating: 1,   
        progress: 0
      )

      @artist.albums << @album
      @artist.songs << @song
      @album.songs << @song
    end

    describe 'GET index' do
      it 'returns http status ok' do
          get :index
          expect(response).to have_http_status(:ok)
      end
      it 'render json with all artists' do
          get :index
          artists = JSON.parse(response.body)
          expect(artists.size).to eq 1
      end
    end

    describe 'GET show' do
      it 'returns http status ok' do
          get :show, params: { id: @artist }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct artist' do
          get :show, params: { id: @artist }
          expected_artist = JSON.parse(response.body)
          expect(expected_artist["id"]).to eq(@artist.id)
      end
    end

    describe 'GET songs' do
      it 'returns http status ok' do
          get :songs, params: { id: @artist }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct songs of the artist' do
          get :songs, params: { id: @artist }
          expected_songs = JSON.parse(response.body)
          expected_songs.each.with_index do |song, index|
            expect(song["id"]).to eq(@artist.songs[index].id)
          end
      end
    end

    describe 'GET albums' do
      it 'returns http status ok' do
          get :albums, params: { id: @artist }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct albums of the artist' do
          get :albums, params: { id: @artist }
          expected_albums = JSON.parse(response.body)
          expected_albums.each.with_index do |album, index|
            expect(album["id"]).to eq(@artist.albums[index].id)
          end
      end
    end

    describe 'GET search' do
      it 'returns http status ok' do
        get :search, params: { name: @artist.name }
        expect(response).to have_http_status(:ok)
      end

      it 'render the correct searched artist' do
        get :search, params: { name: @artist.name }
        expected_artist = JSON.parse(response.body)
        expect(expected_artist[0]["name"]).to eq(@artist.name)
      end
    end
  end
end