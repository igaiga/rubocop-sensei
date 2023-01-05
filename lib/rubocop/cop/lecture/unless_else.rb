# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      class UnlessElse < ::RuboCop::Cop::Style::UnlessElse
        MSG = <<~STRING
          `unless` `else` は避けた方が良いです。
          `if` をつかって書き直すと読みやすくなります。

          unless x == 1
            puts "foo"
          else
            puts "bar"
          end

          ifをつかって書き直した例です。

          if x == 1
            puts "bar"
          else
            puts "foo"
          end

          このCopは RuboCop gem Style/UnlessElse と同じ内容です。
        STRING
      end
    end
  end
end
