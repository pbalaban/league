class LeagueTable
  STAT_METHODS = %i(get_points get_goals_for get_goals_against get_goal_difference get_wins get_draws get_losses)

  include ActiveModel::Model

  attr_accessor :matches

  def matches
    @matches ||= []
  end

  STAT_METHODS.each do |method_name|
    define_method method_name do |team_name|
      recalculate_matches

      (Team.find_by(name: team_name) || Team.new).send(method_name)
    end
  end

  private
  # TODO: perfomance optimization needed, I'm use this method because can't
  #   paticipate to :matches collection adding/removing events.
  #   This method can removed, if I change match adding interface
  #   for example: matches.parse('Man Utd 3 - 0 Liverpool')
  def recalculate_matches
    Match.destroy_all

    self.matches.each do |match_str|
      Match.parse(match_str)
    end
  end
end
