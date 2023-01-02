# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # `elsif`は`case`で書き換え可能です。
      # N個の分岐から1つ選ぶ「N者択一」のときはcaseをつかうと読みやすくなります。
      #
      # @example
      #   # bad
      #   if x == 1
      #     do_something1
      #   elsif y == 2
      #     do_something2
      #   end
      #
      #   # good
      #   case
      #   when x == 1
      #     do_something1
      #   when y == 2
      #     do_something2
      #   end
      #
      #   # good
      #   case x
      #   when (1..20)
      #     do_something1
      #   when (21..)
      #     do_something2
      #   end
      #
      class ReplaceElsif < Base
        extend RuboCop::Cop::AutoCorrector

        MSG = <<~STRING
          `elsif`は`case`で書き換え可能です。
          N個の分岐から1つ選ぶ「N者択一」のときはcaseをつかうと読みやすくなります。

          たとえば、elsifをつかった次のようなコードがあるとき、

          if x == 1
          elsif y == 2
          else
          end

          caseをつかうと次のように書き換えられます。

          case
          when x == 1
          when y == 2
          else
          end

          同じ変数の値で分岐するときは次のようにも書けます。

          case x
          when 1
          when 2
          else
          end
        STRING

        def on_if(node)
          return unless node.elsif?

          add_offense(node) do |corrector|
            # if => case when
            replacing_string = "case" + "\n" +
             " " * node.parent.source_range.column + "when"
            corrector.replace(node.parent.loc.keyword, replacing_string)
            corrector.replace(node.loc.keyword, "when") # elsif => when
          end
        end
      end
    end
  end
end
