require 'rails_helper'

module Api
    describe AlbumsController do
        before do
            @artist = Artist.create(
              name: holi,
              age: 50
            )  
            @songs = Song.create( 
            title: "verte ir",
            duration: 2050,
            rating: rand(5) + 1,   
            progress: 0
            )
            
        end
        describe 'GET show' do
            it 'returns http status ok' do
                get :show, params: { id: @album }
                expect(response).to have_http_status(:ok)
            end
            it 'render the correct @episode' do
                get :show, params: { id: @ealbum }
                expected_episode = JSON.parse(response.body)
                expect(expected_episode["id"]).to eq(@album.id)
            end
        end

        describe "PATCH update" do
            it "returns http status ok" do
                patch :update, params: { 
                    id: @episode, 
                    playback: 360
                    }
                expect(response).to have_http_status(:ok)
            end
            it "returns the updated @episode" do
                patch :update, params: { 
                    id: @episode, 
                    playback: 360
                    }
                expected_episode = JSON.parse(response.body)
                expect(expected_episode["playback"]).to eq(360)
            end
        end
    end
end 