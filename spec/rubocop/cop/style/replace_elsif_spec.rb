# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Style::ReplaceElsif, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when using `elsif`" do
    expect_offense(<<~RUBY)
      x = 1
      y = 2
      if x == 9
      elsif y == 2
      ^^^^^^^^^^^^ `elsif`は`case`で書き換え可能です。[...]
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      x = 1
      y = 2
      case
      when x == 9
      when y == 2
      end
    RUBY
  end


  it "auto corrected code is valid" do
    expect_offense(<<~RUBY)
      x = 1
      y = 2
      if x == 9
        puts "foo"
      elsif y == 2
      ^^^^^^^^^^^^ `elsif`は`case`で書き換え可能です。[...]
        puts "bar"
      else
        puts "baz"
      end
    RUBY

    corrected_code = <<~RUBY
      x = 1
      y = 2
      case
      when x == 9
        puts "foo"
      when y == 2
        puts "bar"
      else
        puts "baz"
      end
    RUBY

    expect_correction(corrected_code)
  end
end
