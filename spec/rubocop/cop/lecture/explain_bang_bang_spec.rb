# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainBangBang, :config do
  let(:config) { RuboCop::Config.new }

  it "!!" do
    expect_offense(<<~RUBY)
      foo = 1
      !!foo
      ^^^^^ Lecture/ExplainBangBang: [...]
    RUBY
  end

  it "not !!" do
    expect_no_offenses(<<~RUBY)
      !foo
    RUBY
  end
end
