describe Match do
  include MatchHelper

  let(:team_with_digits){ 'Schalke 04 0 - 1 Liverpool' }
  let(:goal_with_many_digits){ 'Liverpool 123 - 11 Man Utd' }
  let(:with_many_spaces){ 'Liverpool     123    -    11     Man    Utd' }
  let(:bad_result_formats) do
    ['', nil, 'Liverpool 123  11 Man Utd', 'Liverpool  - 11 Man Utd', ' 123 - 11 Man Utd',
      'Liverpool 123 -  Man Utd', 'Liverpool 123 - 11 ', 'Liverpool Man Utd']
  end

  it "DEFAULT_ATTRS ordered" do
    Match::DEFAULT_ATTRS.must_equal %i(home_team_name home_team_goals away_team_goals away_team_name)
  end

  describe "class methods" do
    it '#parse' do
      attributes_for_compare(Match.parse(team_with_digits)).must_equal ['Schalke 04', 0, 1, 'Liverpool']
      attributes_for_compare(Match.parse(goal_with_many_digits)).must_equal ['Liverpool', 123, 11, 'Man Utd']
      attributes_for_compare(Match.parse(with_many_spaces)).must_equal ['Liverpool', 123, 11, 'Man    Utd']

      bad_result_formats.each do |bad_format|
        err = ->{ attributes_for_compare(Match.parse(bad_format)) }.must_raise RuntimeError
        err.message.must_match %r{<Home team> <Home team goals> - <Away team goals> <Away team>}
      end
    end
  end
end
