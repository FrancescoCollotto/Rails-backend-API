class MatchesController < ApplicationController
  POINTS_PERCENTAGE = 0.1
  def create
    @winner = Player.find_by(name: params[:winner])
    @loser = Player.find_by(name: params[:loser])
    if @winner && @loser
      @match = Match.new(winner_id: @winner.id, loser_id: @loser.id)
      if @match.save
        update_players_points
        render json: @match, status: :created
      else
        render json: @match.errors, status: :unprocessable_entity
      end
    else
      render json: { error: 'record not found' }, status: :unprocessable_entity
    end
  end

  def update_players_points
    match_points = (@loser.points * POINTS_PERCENTAGE).floor
    loser_points = @loser.points - match_points
    winner_points = @winner.points + match_points
    @loser.update(points: loser_points)
    @winner.update(points: winner_points)
    @loser.save
    @winner.save
  end

  private
    def match_params
      params.require(:match).permit(:winner_id, :loser_id)
    end
end
