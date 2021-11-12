# frozen_string_literal: true

module Api
  module V1
    class ScoresController < ApplicationController
      before_action :find_score, only: %i[show destroy]
      # GET /score
      def show
        render json: @score
      end

      def create
        @score = Score.new(score_params)
        if @score.save!
          render json: @score
        else
          render json: { error: 'Failed to create score.' }, status: 400
        end
      end

      def destroy
        if @score
          @score.destroy!
          render json: { message: 'Score succesfully deleted.' }, status: 200
        else
          render json: { error: 'Failed to delete score.' }, status: 400
        end
      end

      def filter_score
        @filter_scores = Score.where(nil)
        @filter_scores = @filter_scores.player(params[:players]) if params[:players].present?

        @filter_scores = if params[:before].present? && params[:after].present?
                           @filter_scores.datetime(params[:before], params[:after])
                         elsif params[:before].present?
                           @filter_scores.created_before(params[:before])
                         else
                           @filter_scores.created_after(params[:after])
                         end

        paginate json: @filter_scores, status: 200
      end

      def player_history
        if params[:player].is_a? String
          @all_scores = []
          
          @player = Score.player(params[:player])
          @player.each do |p|
            @all_scores << {"score": p.score, "created_at": p.created_at}
          end

          result = {
            "max_score": @player.maximum('score'),
            "low_score": @player.minimum('score'),
            "avg_score": @player.average('score').to_f,
            "all_scores": @all_scores
          }

          render json: result, status: 200
        else
          render json: { error: 'player parameters should be in String' }, status: 400
        end
      end

      private

      def score_params
        params.permit(:score, :player)
      end

      def filter_scores_params
        params.permit(:before, :after, :players)
      end

      def find_score
        @score = Score.find(params[:id])
      end
    end
  end
end
