class MatchesController < ApplicationController
  POINTS_PERCENTAGE = 0.1
  def create
    @winner = Player.find_by(name: params[:winner])
    @loser = Player.find_by(name: params[:loser])
    if @winner && @loser
      @match = Match.new(winner_id: @winner.id, loser_id: @loser.id)
      if @match.save
        render json: @match, status: :created
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'record not found' }, status: :unprocessable_entity
    end
  end

  def update_players_points

  end

  private
    def match_params
      params.require(:match).permit(:winner_id, :loser_id)
    end
end
