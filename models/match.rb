class Match
  RESULT_REGEXP = /(.+)\s+(\d+)\s+-\s+(\d+)\s+(.+)/
  DEFAULT_ATTRS = %i(home_team home_team_goals away_team_goals away_team)

  include ActiveModel::Model

  attr_accessor *DEFAULT_ATTRS

  def self.parse formatted_str
    captures = formatted_str.to_s.match(RESULT_REGEXP).try(:captures) || []

    if !captures.size.eql?(4) || captures.any?(&:blank?)
      raise %{Can't parse input string. Should be in format like:
        '<Home team> <Home team goals> - <Away team goals> <Away team>'}
    end

    self.new.tap do |m|
      DEFAULT_ATTRS.map{ |attr| m.send(:"#{attr}=", captures.shift) }
    end
  end

  def home_team
    @home_team.to_s.strip
  end

  def home_team_goals
    @home_team_goals.to_i
  end

  def away_team_goals
    @away_team_goals.to_i
  end

  def away_team
    @away_team.to_s.strip
  end
end
