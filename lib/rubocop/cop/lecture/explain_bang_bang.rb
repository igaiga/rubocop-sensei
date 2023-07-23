# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # `!!`はオブジェクトをtrueまたはfalseに変換する書き方です。
      # 真偽反転の!が2回つかわれていると解釈すれば意味を取りやすいです。
      # nilまたはfalseのときはfalseへ、それ以外はtrueへ変換します。
      # !!は必ずtrueまたはfalseに変換するので、任意のオブジェクトやnilをメソッドから返したくないときによくつかわれます。
      # メソッド名の末尾が?で終わるメソッドはtrue/falseを返す慣習になっているので、!!が便利につかえる場面が多いです。
      # 一方で、ifで判定するときなど、メソッドの戻り値としてつかわないときは!!をつけずにそのままつかうことが多いです。
      #
      # @example
      #   # good
      #   foo = 1
      #   !!foo
      #
      class ExplainBangBang < Base
        MSG = <<~STRING
          `!!`はオブジェクトをtrueまたはfalseに変換する書き方です。
          真偽反転の!が2回つかわれていると解釈すれば意味を取りやすいです。
          nilまたはfalseのときはfalseへ、それ以外はtrueへ変換します。

          !!は必ずtrueまたはfalseに変換するので、任意のオブジェクトやnilをメソッドから返したくないときによくつかわれます。
          メソッド名の末尾が?で終わるメソッドはtrue/falseを返す慣習になっているので、!!が便利につかえる場面が多いです。

          一方で、ifで判定するときなど、メソッドの戻り値としてつかわないときは!!をつけずにそのままつかうことが多いです。
        STRING

        RESTRICT_ON_SEND = %i[!].freeze

        def on_send(node)
          if node.send_type? && node.method_name == :!
            if node.children.any?{|n| n.respond_to?(:send_type?) && n.send_type? && n.method_name == :! }
              add_offense(node)
              return
            end
          end
        end
      end
    end
  end
end
