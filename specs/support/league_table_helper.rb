module LeagueTableHelper
  def all_league_with_all_teams
    league_examples.each do |league|
      team_name_examples.each do |team_name|
        yield league, team_name
      end
    end
  end
end
