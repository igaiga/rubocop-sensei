# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # 1行パターンマッチです。
      # [1,2,3] => [x,y,3]
      # p x #=> 1
      # p y #=> 2
      # =>の右側には変数入りのパターンを書くことができ、左側と対応させ、それぞれの変数に代入します。
      #
      # @example
      #   # good
      #   5 => x
      #   p x #=> 5
      #
      #   # good
      #   [1,2,3] => [x,y,3]
      #   p x #=> 1
      #   p y #=> 2
      #
      class ExplainPatternMatchRocket < Base
        MSG = <<~STRING
          1行パターンマッチです。
          =>の右側には変数入りのパターンを書くことができ、左側と対応させ、それぞれの変数に代入します。

          [1,2,3] => [x,y,3]
          p x #=> 1
          p y #=> 2

          5 => x
          p x #=> 5
        STRING

        def on_match_pattern(node)
          add_offense(node)
        end
      end
    end
  end
end
