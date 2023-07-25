# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # `&.`はレシーバのnilチェックをしてメソッド呼び出しをする演算子です。
      # foo&.methodでは、fooがnilのときはメソッド呼び出しをせずnilを返し、fooがnil以外ではmethodメソッドを呼び出します。
      #
      # &.は通称「ぼっち演算子」とも呼ばれます。人が1人でひざを抱えて座っているように見えるからです。
      #
      # @example
      #   # good
      #   foo = nil
      #   foo&.upcase #=> nil
      #
      #   # good
      #   foo = "ruby"
      #   foo&.upcase #=> "RUBY"
      #
      class ExplainLonelyOperator < Base
        MSG = <<~STRING
          `&.`はレシーバのnilチェックをしてメソッド呼び出しをする演算子です。
          foo&.methodでは、fooがnilのときはメソッド呼び出しをせずnilを返し、fooがnil以外ではmethodメソッドを呼び出します。

          &.は通称「ぼっち演算子」とも呼ばれます。人が1人でひざを抱えて座っているように見えるからです。
        STRING

        def on_csend(node)
          add_offense(node)
        end
      end
    end
  end
end
