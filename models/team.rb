class Team < ActiveRecord::Base
  has_many :games, dependent: :destroy

  has_many :win_games, ->{ where(result: :win) }, class_name: :Game
  has_many :draw_games, ->{ where(result: :draw) }, class_name: :Game
  has_many :loss_games, ->{ where(result: :loss) }, class_name: :Game

  def get_points
    self.games.sum(:points)
  end

  def get_goals_for
    self.games.sum(:goal_scored)
  end

  def get_goals_against
    self.games.sum(:goal_conceded)
  end

  def get_goal_difference
    self.get_goals_for - self.get_goals_against
  end

  def get_wins
    self.win_games.count
  end

  def get_draws
    self.draw_games.count
  end

  def get_losses
    self.loss_games.count
  end
end
