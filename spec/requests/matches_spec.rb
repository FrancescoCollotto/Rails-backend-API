require 'rails_helper'

RSpec.describe "Matches", type: :request do
  describe "POST /matches" do
    before(:each) do
      @player1 = Player.create(name: "Roger Federer", nationality: "Switzerland", birthday: "08-08-1981")
      @player2 = Player.create(name: "Rafael Nadal", nationality: "Spain", birthday: "03-06-1986")
    end
    # it "returns http success" do
    #   get "/matches/create"
    #   expect(response).to have_http_status(:success)
    # end

    it "returns http created status" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/matches", :params => '{ "winner":"Roger Federer", "loser":"Rafael Nadal" }', :headers => headers
      expect(response).to have_http_status(:created)
    end
    
    it "returns http unprocessable_entity status" do
      headers = { "CONTENT_TYPE" => "application/json" }
      post "/matches", :params => '{ "winner":"Matteo Berrettini", "loser":"Rafael Nadal" }', :headers => headers
      expect(response).to have_http_status(:unprocessable_entity)
    end 
  end

end
