describe Match do
  let(:team_with_digits){ 'Schalke 04 0 - 1 Liverpool' }
  let(:goal_with_many_digits){ 'Liverpool 123 - 11 Man Utd' }

  let(:match_attributes){  }

  describe 'instance methods' do
    subject{ Match.new }

    it{ subject.must_respond_to :home_team }
    it{ subject.home_team.must_be_instance_of String }

    it{ subject.must_respond_to :home_team_goals }
    it{ subject.home_team_goals.must_be_instance_of Fixnum }

    it{ subject.must_respond_to :away_team_goals }
    it{ subject.away_team_goals.must_be_instance_of Fixnum }

    it{ subject.must_respond_to :away_team }
    it{ subject.away_team.must_be_instance_of String }
  end

  it '#parse' do
    attributes_for_compare(Match.parse(team_with_digits)).must_equal ['Schalke 04', 0, 1, 'Liverpool']
    attributes_for_compare(Match.parse(goal_with_many_digits)).must_equal ['Liverpool', 123, 11, 'Man Utd']
  end

  def attributes_for_compare match
    %i(home_team home_team_goals away_team_goals away_team).map{ |attr| match.send(attr) }
  end
end
