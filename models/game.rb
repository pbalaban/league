class Game < ActiveRecord::Base
  AWARDS_POINTS = { draw: 1, win: 3, loss: 0 }

  belongs_to :match
  belongs_to :team

  before_save :create_game_stat

  def team_name= name
    @team_name = name
    @team = Team.where(name: name).first_or_create
  end

  def goal_difference
    self.goal_scored - self.goal_conceded
  end

  def detect_result
    AWARDS_POINTS.keys[self.goal_difference <=> 0]
  end

  private
  def create_game_stat
    self.result = self.detect_result
    self.points = AWARDS_POINTS[self.result.to_sym]
  end
end
