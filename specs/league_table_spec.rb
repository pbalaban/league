describe LeagueTable do
  let(:empty_league){ LeagueTable.new }
  let(:simple_league){ LeagueTable.new.tap{ |lt| lt.matches.push('Man Utd 3 - 0 Liverpool') } }
  let(:complicated_league) do
    LeagueTable.new.tap do |lt|
      lt.matches.push('Man Utd 3 - 0 Liverpool', 'Liverpool 1 - 0 Tottenham', 'Liverpool 1 - 1 Chelsea')
    end
  end

  let(:league_examples){ [empty_league, simple_league, complicated_league] }
  let(:team_name_examples){ [nil, '', 'Liverpool', 'Unknown'] }

  it 'instance methods' do
    league_examples.each do |league|
      league.must_respond_to :matches
      league.matches.must_be_instance_of Array
    end
  end

  describe 'stat methods' do
    describe 'defaults' do
      it{ all_league_with_all_teams{ |l, t| l.get_points(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_goals_for(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_goals_against(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_goal_difference(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_wins(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_draws(t).must_equal 0 } }
      it{ all_league_with_all_teams{ |l, t| l.get_losses(t).must_equal 0 } }
    end
  end

  def all_league_with_all_teams
    league_examples.each do |league|
      team_name_examples.each do |team_name|
        yield league, team_name
      end
    end
  end
end
