class MatchesController < ApplicationController
  def create
    @match = Match.new(winner_id: 1, loser_id: 2)
    if @match.save
      render json: @match, status: :created
    else
      render json: @match.errors, status: :unprocessable_entity
    end
  end
end
