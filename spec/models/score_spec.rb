# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Score, type: :model do

  DatabaseCleaner.clean
  before(:all) do
    @today = Time.now
    @score1 = create(:score)
    @score2 = Score.create(score: Faker::Number.between(from: 1, to: 10), player: @score1.player.upcase)
    @score3 = Score.create(score: Faker::Number.between(from: 1, to: 10), player: @score1.player.downcase,
                           created_at: @today - 2.week)
    @score4 = Score.create(score: Faker::Number.between(from: 1, to: 10), player: "TIm")
  end

  describe Score do
    it { is_expected.to validate_presence_of(:score) }
    it { is_expected.to validate_presence_of(:player) }
  end

  describe 'scope' do
    describe ':player' do
      it 'returns a player' do
        expect(Score.player(@score1.player)).to include(@score1, @score2, @score3)
        expect(Score.player(@score1.player)).to_not include(@score4)
      end

      it 'returns multiple players' do
        expect(Score.player([@score1.player, @score4.player])).to include(@score1, @score2, @score3, @score4)
      end
    end
    
    describe ':datetime' do
      it 'returns score if score.created_at is in range of params[:before] and params[:after]' do
        expect(Score.datetime(@today + 1.day, @today - 3.day)).to include(@score1, @score2, @score4)
        expect(Score.datetime(@today + 1.day, @today - 3.day)).to_not include(@score3)
      end
    end
    
    describe ':before' do
      it 'returns score if score.created_at is in range of params[:before]' do
        expect(Score.created_before(@today - 1.week)).to include(@score3)
        expect(Score.created_before(@today - 1.week)).to_not include(@score1, @score2, @score4)
      end
    end
    
    describe ':after' do
      it 'returns score if score.created_at is in range of params[:after]' do
        expect(Score.created_after(@today)).to include(@score1, @score2, @score4)
        expect(Score.created_after(@today)).to_not include(@score3)
      end
    end
  end
end
