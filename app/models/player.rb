class Player < ApplicationRecord
  has_many :winners, class_name: "Player", foreign_key: "winner_id"
  has_many :losers, class_name: "Player", foreign_key: "loser_id"

  validates :name, presence: true, uniqueness: true
  validates :nationality, presence: true
  validates :birthday, presence: true, age: true
end
