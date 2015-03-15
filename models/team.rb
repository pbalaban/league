class Team
  include ActiveModel::Model

  attr_accessor :name

  def name
    @name.to_s
  end
end
