describe LeagueTable do
  include LeagueTableHelper

  let(:empty_league){ LeagueTable.new }
  let(:simple_league){ LeagueTable.new.tap{ |lt| lt.matches.push('Man Utd 3 - 0 Liverpool') } }
  let(:complicated_league) do
    LeagueTable.new.tap do |lt|
      lt.matches.push('Man Utd 3 - 0 Liverpool', 'Liverpool 1 - 0 Tottenham', 'Liverpool 1 - 1 Chelsea')
    end
  end
  let(:league_from_task) do
    LeagueTable.new.tap{ |lt| lt.matches.push('Man Utd 3 - 0 Liverpool') }
  end

  let(:league_examples){ [empty_league, simple_league, complicated_league] }
  let(:team_name_examples){ [nil, '', 'Unknown'] }

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

    it 'from task' do
      league_from_task.get_goals_for("Man Utd").must_equal 3
      league_from_task.get_points("Man Utd").must_equal 3
      league_from_task.get_points("Liverpool").must_equal 0
      league_from_task.get_goal_difference("Liverpool").must_equal -3

      league_from_task.matches.push("Liverpool 1 - 1 Man Utd")

      league_from_task.get_goals_for("Man Utd").must_equal 4
      league_from_task.get_points("Man Utd").must_equal 4
      league_from_task.get_points("Liverpool").must_equal 1
      league_from_task.get_goals_against("Man Utd").must_equal 1

      league_from_task.get_points("Tottenham").must_equal 0
    end

    it 'for complicated league' do
      complicated_league.get_points("Man Utd").must_equal 3
      complicated_league.get_points("Liverpool").must_equal 4
      complicated_league.get_points("Tottenham").must_equal 0
      complicated_league.get_points("Chelsea").must_equal 1

      complicated_league.get_goals_for("Man Utd").must_equal 3
      complicated_league.get_goals_for("Liverpool").must_equal 2
      complicated_league.get_goals_for("Tottenham").must_equal 0
      complicated_league.get_goals_for("Chelsea").must_equal 1

      complicated_league.get_goals_against("Man Utd").must_equal 0
      complicated_league.get_goals_against("Liverpool").must_equal 4
      complicated_league.get_goals_against("Tottenham").must_equal 1
      complicated_league.get_goals_against("Chelsea").must_equal 1

      complicated_league.get_goal_difference("Man Utd").must_equal 3
      complicated_league.get_goal_difference("Liverpool").must_equal -2
      complicated_league.get_goal_difference("Tottenham").must_equal -1
      complicated_league.get_goal_difference("Chelsea").must_equal 0

      complicated_league.get_wins("Man Utd").must_equal 1
      complicated_league.get_wins("Liverpool").must_equal 1
      complicated_league.get_wins("Tottenham").must_equal 0
      complicated_league.get_wins("Chelsea").must_equal 0

      complicated_league.get_draws("Man Utd").must_equal 0
      complicated_league.get_draws("Liverpool").must_equal 1
      complicated_league.get_draws("Tottenham").must_equal 0
      complicated_league.get_draws("Chelsea").must_equal 1

      complicated_league.get_losses("Man Utd").must_equal 0
      complicated_league.get_losses("Liverpool").must_equal 1
      complicated_league.get_losses("Tottenham").must_equal 1
      complicated_league.get_losses("Chelsea").must_equal 0
    end
  end
end
