class Match < ActiveRecord::Base
  RESULT_REGEXP = /(.+)\s+(\d+)\s+-\s+(\d+)\s+(.+)/
  DEFAULT_ATTRS = %i(home_team_name home_team_goals away_team_goals away_team_name)

  has_many :games, dependent: :destroy

  after_create :create_games

  def self.parse formatted_str
    captures = formatted_str.to_s.match(RESULT_REGEXP).try(:captures) || []
    captures.map!(&:strip)

    if !captures.size.eql?(4) || captures.any?(&:blank?)
      raise %{Can't parse input string. Should be in format like:
        '<Home team> <Home team goals> - <Away team goals> <Away team>'}
    end

    attrs = DEFAULT_ATTRS.map.with_object({}) do |attr, memo|
      memo[attr] = captures.shift
    end

    self.create attrs
  end

  private
  def create_games
    self.games.create(
      team_name: self.home_team_name,
      goal_scored: self.home_team_goals,
      goal_conceded: self.away_team_goals
    )

    self.games.create(
      team_name: self.away_team_name,
      goal_scored: self.away_team_goals,
      goal_conceded: self.home_team_goals
    )
  end
end
