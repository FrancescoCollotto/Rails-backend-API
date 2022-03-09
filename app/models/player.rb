class Player < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :nationality, presence: true
  validates :birthday, presence: true
end
