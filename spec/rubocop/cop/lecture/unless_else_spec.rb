# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::UnlessElse, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when using `elsif`" do
    expect_offense(<<~RUBY)
      x = 1
      unless x == 1
      ^^^^^^^^^^^^^ `unless` `else` は避けた方が良いです。[...]
      else
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      x = 1
      if x == 1
      else
      end
    RUBY
  end
end
