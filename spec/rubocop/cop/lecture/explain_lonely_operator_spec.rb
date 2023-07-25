# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainLonelyOperator, :config do
  let(:config) { RuboCop::Config.new }

  it "&." do
    expect_offense(<<~RUBY)
      foo&.upcase
      ^^^^^^^^^^^ Lecture/ExplainLonelyOperator: [...]
    RUBY
  end

  it "not &." do
    expect_no_offenses(<<~RUBY)
      foo.upcase
    RUBY
  end
end
