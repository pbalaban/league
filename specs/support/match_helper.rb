module MatchHelper
  def attributes_for_compare match
    Match::DEFAULT_ATTRS.map{ |attr| match.send(attr) }
  end
end
