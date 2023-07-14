# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::ExplainNumberedParameters, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when having a numbered parameter" do
    expect_offense(<<~RUBY)
      ["a","b"].map{ _1.updace }
      ^^^^^^^^^^^^^^^^^^^^^^^^^^ Lecture/ExplainNumberedParameters: foo.bar{ _1.baz } は foo.bar{|x| x.baz } と同じです[...]
    RUBY
  end

  it "Registers an offense when having a numbered parameter" do
    expect_offense(<<~RUBY)
      ["a","b"].map{ _1 }
      ^^^^^^^^^^^^^^^^^^^ Lecture/ExplainNumberedParameters: foo.bar{ _1.baz } は foo.bar{|x| x.baz } と同じです[...]
    RUBY
  end

  it "Registers an offense when having a numbered parameter" do
    expect_offense(<<~RUBY)
      [1,2].map do
      ^^^^^^^^^^^^ Lecture/ExplainNumberedParameters: foo.bar{ _1.baz } は foo.bar{|x| x.baz } と同じです[...]
        _1 * 2
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      ["a","b"].map do |x|
        x.upcase
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      [1].map{|x| x * 2}
    RUBY
  end
end
