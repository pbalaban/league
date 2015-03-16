ActiveRecord::Base.establish_connection YAML.load(File.read('config/database.yml'))
ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Schema.define do
  create_table :teams, force: true  do |t|
    t.string :name, null: false
  end

  add_index :teams, :name, unique: true

  create_table :matches, force: true  do |t|
    t.integer :home_team_goals, null: false, default: 0
    t.integer :away_team_goals, null: false, default: 0
    t.string  :home_team_name, null: false
    t.string  :away_team_name, null: false
  end
end
