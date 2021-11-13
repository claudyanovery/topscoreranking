# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::ScoresController, type: :request do
  before(:all) do
    @invalid_score = Score.create(score: -3, player: "Ray")
    @score1 = Score.create(score: 1, player: "Tom")
  end
  

  describe "GET /scores/:id" do
    let(:expected_show_response) do
        {
            "id" => @score1.id,
            "player" => @score1.player,
            "score" => @score1.score,
            "created_at" => @score1.created_at.strftime('%Y-%m-%dT%H:%M:%S.%3NZ'),
            "updated_at" => @score1.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
        }
    end

    it "return score" do
        get "/api/v1/scores/#{@score1.id}"
        expect(JSON.parse(response.body)).to eq(expected_show_response)        
    end

    it "return status 200" do
        get "/api/v1/scores/#{@score1.id}"
        expect(response.status).to eq(200)
    end


  end

  describe 'POST /api/v1/scores' do
    let(:valid_params) do
        {
            "score" => 4,
            "player" => "Nancy"
        }
    end

    it 'checks that a score is invalid' do
        expect(@invalid_score).to be_invalid
    end

    it 'checks that a score can be created' do
      expect(@score1).to be_valid
    end

    it 'create new score' do
      post '/api/v1/scores', params: valid_params
      expect(response.status).to eq(200)
    end

  end

  describe 'DESTROY /api/v1/scores' do
    it 'destroy score' do
      delete "/api/v1/scores/#{@score1.id}"
      expect(response.status).to eq(200)
    end
  end

  describe "POST /api/v1/filter_score" do
    let(:filter_score_params) do
        {
            "after" => Time.now - 1.hour,
            "before" => Time.now + 1.hour,
            "players" => @score1.player
        }
    end
    
    let(:expected_filter_score_response) do
        [
            {
                "id" => @score1.id,
                "player" => @score1.player,
                "score" => @score1.score,
                "created_at" => @score1.created_at.strftime('%Y-%m-%dT%H:%M:%S.%3NZ'),
                "updated_at" => @score1.updated_at.strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
            }
        ]
    end
      it 'returns players when params[:player] exists' do
        post '/api/v1/filter_score', params: filter_score_params
        expect(JSON.parse(response.body)).to eq(expected_filter_score_response)
      end
  end

  describe "POST /api/v1/player_history" do
    let(:player_history_params) do
        {
            "player" => @score1.player
        }
    end

    let(:expected_player_history_response) do
        {
            "max_score" => 1,
            "low_score" => 1,
            "avg_score" => 1.0,
            "all_scores" => [
                {
                    "score" => @score1.score,
                    "created_at" => @score1.created_at.strftime('%Y-%m-%dT%H:%M:%S.%3NZ')
                }       
            ]
        }
    end

    it "returns player history" do
        post '/api/v1/player_history', params: player_history_params

        expect(JSON.parse(response.body)).to eq(expected_player_history_response)
    end
  end
  
end
