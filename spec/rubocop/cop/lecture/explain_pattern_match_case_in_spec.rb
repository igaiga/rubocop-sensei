# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainPatternMatchCaseIn, :config do
  let(:config) { RuboCop::Config.new }

  it "case in" do
    expect_offense(<<~RUBY)
      case [1,2]
      ^^^^^^^^^^ Lecture/ExplainPatternMatchCaseIn: case in はパターンマッチ[...]
      in [1,x]
      end
    RUBY
  end
end
