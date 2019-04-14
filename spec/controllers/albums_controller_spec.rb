require 'rails_helper'
module Api
    describe AlbumsController do
        before do
          @artist = Artist.create(
              name: 'anuel',
              age: 34
            )  
          @song = Song.create( 
            title: "verte ir",
            duration: 2050,
            rating: 1,   
            progress: 0
            )
          @album = Album.create(
              title: "bebecita",
              rating: -1
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
          it 'render json with all album' do
            get :index
            albums = JSON.parse(response.body)
            expect(albums.size).to eq 1
          end
        end   

        describe 'GET show' do
          it 'returns http status ok' do
            get :show, params: { id: @album }
            expect(response).to have_http_status(:ok)
            end
          it 'render the correct @albums' do
            get :show, params: { id: @album }
            expected_album = JSON.parse(response.body)
            expect(expected_album["id"]).to eq(@album.id)
          end
        end

        describe "GET api/songs/:id/albums" do
          it "List specific albums" do
            get :index, params: { song_id: @song.id }
            albums = JSON.parse(response.body)
            expect(albums.size).to eq 1
            expect(albums[0]["title"]).to eq("bebecita")
          end
        end

        describe "PATCH: api/album/:id/rating" do
          it "Response with status ok" do
            patch :rating, params: {id: @album.id, rating: 1}
            expect(response).to have_http_status(:ok)
          end
          it "Return the updated album" do
            patch :rating, params: {id: @album.id, rating: 1}
            updated_album = JSON.parse(response.body)
            expect(updated_album["rating"]).to eq(1)
          end
        end
        describe "GET: api/artists/:id/albums" do
          it "Respond with status ok" do
            get :index, params: { artist_id: @artist.id }
            expect(response).to have_http_status(:ok)
          end
          it "List specific albums" do
            get :index, params: { artist_id: @artist.id }
            albums = JSON.parse(response.body)
            expect(albums.size).to eq 1
            expect(albums[0]["title"]).to eq("bebecita")
          end

        describe "Implement GET: api/albums/search with test" do
          it "Response with status ok" do
            get :search, params: {title: "xxx"}
            albums = JSON.parse(response.body)
            expect(albums.size).to eq 0
          end
          it "List albums that matches the search term" do
            get :search, params: {title: "bebecita"}
            albums = JSON.parse(response.body)
            expect(albums.size).to eq 1
            expect(albums[0]["title"]).to eq("bebecita")
          end
        end   
    end
  end 
end
