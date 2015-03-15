describe Team do
  let(:liverpool){ Team.new(name: 'Liverpool') }

  describe 'instance methods' do
    subject{ Team.new }

    it{ subject.must_respond_to :name }
    it{ subject.name.must_be_instance_of String }
    it{ liverpool.name.must_equal 'Liverpool' }
  end
end
