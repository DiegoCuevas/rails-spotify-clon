require 'rails_helper'

module Api
  describe SongsController do
    before do
      @artist = Artist.create(
        name: "Metallica",
        age: 38
      )
      @album = Album.create(
        title: "Death Magnetic",
        rating: 1
      )
      @song = Song.create(
        title: "The day that never comes",
        duration: 476,
        rating: 1,   
        progress: 0
      )

      @artist.albums << @album
      @album.songs << @song
      @artist.songs << @song
    end

    describe 'GET index' do
      it 'returns http status ok' do
          get :index
          expect(response).to have_http_status(:ok)
      end
      it 'render json with all songs' do
          get :index
          songs = JSON.parse(response.body)
          expect(songs.size).to eq 1
      end
    end

    describe 'GET show' do
      it 'returns http status ok' do
          get :show, params: { id: @song }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct @song' do
          get :show, params: { id: @song }
          expected_song = JSON.parse(response.body)
          expect(expected_song["id"]).to eq(@song.id)
      end
    end

    describe 'GET artists' do
      it 'returns http status ok' do
          get :artists, params: { id: @song }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct artist of the song' do
          get :artists, params: { id: @song }
          expected_artist = JSON.parse(response.body)
          expected_artist.each.with_index do |artist, index|
            expect(artist["id"]).to eq(@song.artists[index].id)
          end
      end
    end

    describe 'GET albums' do
      it 'returns http status ok' do
          get :albums, params: { id: @song }
          expect(response).to have_http_status(:ok)
      end
      it 'render the correct album of the song' do
          get :albums, params: { id: @song }
          expected_albums = JSON.parse(response.body)
          expected_albums.each.with_index do |album, index|
            expect(album["id"]).to eq(@song.albums[index].id)
          end
      end
    end

    # describe 'GET search' do
    #   it 'returns http status ok' do
    #     get :search, params: { title: @song.title }
    #     expect(response).to have_http_status(:ok)
    #   end

    #   it 'render the correct '
    # end

    describe "PATCH progress" do
      it "returns http status ok" do
        patch :progress, params: { 
          id: @song, 
          progress: 100
          }
        expect(response).to have_http_status(:ok)
      end
      it "returns the updated song progress" do
        patch :progress, params: { 
          id: @song, 
          progress: 100
          }
        expected_song = JSON.parse(response.body)
        expect(expected_song["progress"]).to eq(100)
      end
    end

    describe "PATCH rating" do
      it "returns http status ok" do
        patch :rating, params: { 
          id: @song,
          rating: -1
          }
        expect(response).to have_http_status(:ok)
      end
      it "returns the updated song rating" do
        patch :rating, params: { 
          id: @song,
          rating: -1
          }
        expected_song = JSON.parse(response.body)
        p expected_song
        expect(expected_song["rating"]).to eq(-1)
      end
    end
  end
end