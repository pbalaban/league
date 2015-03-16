class Match < ActiveRecord::Base
  RESULT_REGEXP = /(.+)\s+(\d+)\s+-\s+(\d+)\s+(.+)/
  DEFAULT_ATTRS = %i(home_team_name home_team_goals away_team_goals away_team_name)

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
end
