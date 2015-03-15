module MatchHelper
  def attributes_for_compare match
    %i(home_team home_team_goals away_team_goals away_team).map{ |attr| match.send(attr) }
  end
end
