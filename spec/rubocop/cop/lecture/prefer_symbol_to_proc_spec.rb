# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::PreferSymbolToProc, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when having potential to replace &:method" do
    expect_offense(<<~RUBY)
      ["a","b","c"].map do |x|
      ^^^^^^^^^^^^^^^^^^^^^^^^ Lecture/PreferSymbolToProc: このブロックはmethod(&:method)で置き換えられるかもしれません。[...]
        x.upcase
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      ["a","b","c"].map do |x|
        x.upcase
        x.upcase # having two methods
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      result = []
      [1,2,3].each do |x|
        result.push(x * 2) # having arguments
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      ["a","b","c"].map do |x|
        y = 2 # having others
        x.upcase
      end
    RUBY
    # [s(:args,
    #   s(:arg, :x)),
    #  s(:begin,
    #   s(:lvasgn, :y,
    #     s(:int, 2)),
    #   s(:send,
    #     s(:lvar, :x), :upcase))]
  end
end
