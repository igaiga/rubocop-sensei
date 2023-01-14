# frozen_string_literal: true

RSpec.describe RuboCop::Cop::Lecture::PreferMap, :config do
  let(:config) { RuboCop::Config.new }

  it "Registers an offense when having potential to replace map" do
    expect_offense(<<~RUBY)
      result = []
      [1,2,3].each do |x|
      ^^^^^^^^^^^^^^^^^^^ この`each`メソッドは`map`メソッドで置き換えられるかもしれません。[...]
        result << x * 2
      end
    RUBY
  end

  it "No offenses" do
    expect_no_offenses(<<~RUBY)
      result = []
      [1,2,3].each do |x|
      end
    RUBY
  end
end
