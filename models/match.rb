class Match
  attr_accessor :home_team, :home_team_goals, :away_team_goals, :away_team

  def self.parse formatted_string
    self.new
  end
end
