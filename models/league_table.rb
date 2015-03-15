class LeagueTable
  include ActiveModel::Model

  attr_accessor :matches

  def matches
    @matches ||= []
  end

  def get_points(team_name)
    0
  end

  def get_goals_for(team_name)
    0
  end

  def get_goals_against(team_name)
    0
  end

  def get_goal_difference(team_name)
    0
  end

  def get_wins(team_name)
    0
  end

  def get_draws(team_name)
    0
  end

  def get_losses(team_name)
    0
  end
end
