# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainSymbolToProc, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when having potential to replace &:method" do
    expect_offense(<<~RUBY)
      ["a","b"].map(&:upcase)
      ^^^^^^^^^^^^^^^^^^^^^^^ foo.bar(&:baz) は次のコードと同じです。[...]
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      ["a","b","c"].map do |x|
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      "a".upcase
    RUBY
  end
end
