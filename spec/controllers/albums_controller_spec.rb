require 'rails_helper'

module Api
    describe AlbumsController do
        before do
            @artist = Artist.create(
              name: 'anuel',
              age: 34
            )  
            @songs = Song.create( 
            title: "verte ir",
            duration: 2050,
            rating: 5,   
            progress: 0
            )
            @albums = Album.create(
              title: "bebecita",
              rating: 5
            )
        end
        describe 'GET show' do
            it 'returns http status ok' do
                get :show, params: { id: @albums }
                expect(response).to have_http_status(:ok)
            end
            it 'render the correct @albums' do
                get :show, params: { id: @albums }
                expected_album = JSON.parse(response.body)
                expect(expected_album["id"]).to eq(@albums.id)
            end
        end

        # describe "PATCH update" do
            # it "returns http status ok" do
            #     patch :update, params: { 
            #         id: @albums.id                   
            #         }
            #     expect(response).to have_http_status(:ok)
            # end
            # it "returns the updated @episode" do
            #     patch :update, params: { 
            #         id: @albums                    
            #         }
            #     expected_episode = JSON.parse(response.body)
            #     expect(expected_episode["playback"]).to eq(360)
            # end
        # end
    end
end 