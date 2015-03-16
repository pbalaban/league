describe Game do
  let(:empty_game){ Game.create }
  let(:draw_game){ Game.create(goal_scored: 2, goal_conceded: 2) }
  let(:win_game){ Game.create(goal_scored: 2, goal_conceded: 1) }
  let(:loss_game){ Game.create(goal_scored: 0, goal_conceded: 2) }

  describe 'instance methods' do
    it{ empty_game.goal_difference.must_equal 0 }
    it{ draw_game.goal_difference.must_equal 0 }
    it{ win_game.goal_difference.must_equal 1 }
    it{ loss_game.goal_difference.must_equal -2 }

    it{ draw_game.detect_result.must_equal :draw }
    it{ win_game.detect_result.must_equal :win }
    it{ loss_game.detect_result.must_equal :loss }

    it{ draw_game.result.must_equal 'draw' }
    it{ win_game.result.must_equal 'win' }
    it{ loss_game.result.must_equal 'loss' }

    it{ draw_game.points.must_equal 1 }
    it{ win_game.points.must_equal 3 }
    it{ loss_game.points.must_equal 0 }
  end
end
