class PlayersController < ApplicationController
  def index
    players = Player.all
    
    ranked_players = players.filter { |player| 
      player_matches = Match.where(winner_id: player.id).or(Match.where(loser_id: player.id))
      player_matches.count >= 3
    }
    .map { |player| {name: player.name, nationality: player.nationality, age: calculate_age(player.birthday), points: player.points, rank_name: rank_name(player.points)} }
    .sort_by! { |player| player[:points] }.reverse!

    unranked_players = players.filter { |player| 
      player_matches = Match.where(winner_id: player.id).or(Match.where(loser_id: player.id))
      player_matches.count < 3
    }
    .map { |player| {name: player.name, nationality: player.nationality, age: calculate_age(player.birthday), points: player.points, rank_name: "Unranked"} }
    .sort_by! { |player| player[:points] }.reverse!
   
    all_players = ranked_players + unranked_players
    
    rank = 1
    all_players.map!.with_index { |player, i| 
      player[:rank] = rank
      rank += 1 if (players[i + 1] && players[i + 1][:points] != player[:points]) || players[i + 1] && players[i + 1][:rank_name] != player[:rank_name]
      player
    }

    if params[:nationality] && params[:rank_name]
      filtered_by_natio_and_rank_name = all_players.filter { |player| 
        player[:nationality] == params[:nationality] && player[:rank_name] == params[:rank_name]
      }
      render json: filtered_by_natio_and_rank_name, status: :ok
    elsif params[:nationality]
      filtered_by_nationality = all_players.filter { |player| 
        player[:nationality] == params[:nationality]
      }
      render json: filtered_by_nationality, status: :ok
    elsif params[:rank_name]
      filtered_by_rank_name = all_players.filter { |player|
        player[:rank_name] == params[:rank_name]
      }
      render json: filtered_by_rank_name, status: :ok
    else
      render json: all_players, status: :ok
    end
    
  end

  def create
    @player = Player.new(player_params)

    if @player.save
      render json: @player, status: :created
    else
      render json: @player.errors, status: :unprocessable_entity
    end
  end

  private
    def player_params
      params.require(:player).permit(:name, :nationality, :birthday, :points)
    end

    def rank_name(points)
      if points < 3000
        "Bronze"
      elsif points < 5000
        "Silver"
      elsif points < 10000
        "Gold"
      else
        "Supersonic Legend"
      end
    end

    def calculate_age(dob)
      dob = Date.parse(dob.to_s)
      today = Date.today
      age = today.year - dob.year
      age -= 1 if today.prev_year(age) < dob
      age
    end
end
