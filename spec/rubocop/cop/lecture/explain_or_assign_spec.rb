# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainOrAssign, :config do
  let(:config) { RuboCop::Config.new }

  it "||=" do
    expect_offense(<<~RUBY)
      x ||= 1
      ^^^^^^^ Lecture/ExplainOrAssign: [...]
    RUBY
  end

  it "not ||=" do
    expect_no_offenses(<<~RUBY)
      x  = x || 1
    RUBY
  end
end
