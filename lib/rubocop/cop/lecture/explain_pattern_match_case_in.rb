# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # case in はパターンマッチ構文です。次のようにつかいます。
      # case [1,2,3]
      # in [x,2,3]
      # end
      # p x #=> 1
      # caseにつづけて書いた式（この例では [1,2,3] ）を実行して、結果とマッチするものをin節に書いたパターン群から探します。
      # in節には変数入りのパターンを書くことができ、caseにつづけて書いた式の結果とパターンとを対応させ、それぞれの変数に代入します。
      #
      # 便利なケースは、深いハッシュや配列にマッチさせるときや、複数の変数に代入するときです。
      # case { a: [1,2,3], b: { c: 10 }}
      # in { a: [x,2,3], b: { c: y }}
      # end
      # p x #=> 1
      # p y #=> 10
      #
      # @example
      #   # good
      #   case [1,2,3]
      #   in [x,2,3]
      #   in [x,5,6]
      #   end
      #
      class ExplainPatternMatchCaseIn < Base
        MSG = <<~STRING
          case in はパターンマッチ構文です。次のようにつかいます。
          case [1,2,3]
          in [x,2,3]
          end
          p x #=> 1
          caseにつづけて書いた式（例では [1,2,3] ）を実行して、結果とマッチするものをin節に書いたパターン群から探します。
          in節には変数入りのパターンを書くことができ、caseにつづけて書いた式の結果とパターンとを対応させ、それぞれの変数に代入します。
        STRING

        # 1行inでは呼ばれないことを確認済み
        def on_case_match(node)
          add_offense(node)
        end
      end
    end
  end
end
