# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # `foo ||= 1` は変数fooがnilまたはfalseのときに変数fooへ1を代入し、それ以外のときは何もしません。
      # 変数 ||= 初期値 という形で初期化時によくつかわれます。
      #
      # `foo ||= 1` は `foo = foo || 1` と同じです。
      # || は最初の項がnilまたはfalseのときだけ2項目を戻り値にして、それ以外のときは最初の項を戻り値にします。
      #
      # @example
      #   # good
      #   foo = 555
      #   foo ||= 1
      #   p foo #=> 555
      #
      #   foo = nil
      #   foo ||= 1
      #   p foo #=> 1
      #
      #   # bad
      #   foo = false
      #   foo ||= true
      #   p foo #=> true # 既に代入済みのfalseが上書きされてしまった
      #
      class ExplainOrAssign < Base
        MSG = <<~STRING
          `foo ||= 1` は変数fooがnilまたはfalseのときに変数fooへ1を代入し、それ以外のときは何もしません。
          変数 ||= 初期値 という形で初期化時によくつかわれます。

          `foo ||= 1` は `foo = foo || 1` と同じです。
          || は最初の項がnilまたはfalseのときだけ2項目を戻り値にして、それ以外のときは最初の項を戻り値にします。

          ざっくりと
          「変数に何か入っていたらそのまま、何も入っていなかったら||=の右に書かれたオブジェクトを初期値としてつかう」
          と考えると覚えやすいかもしれません。

          ただし、falseやnilを初期値につかうときは気をつけてください。
          事前に意図的にfalseやnilが代入されているときにも代入されるので、意図しない動作になるかもしれません。
        STRING

        def on_or_asgn(node)
          add_offense(node)
        end
      end
    end
  end
end
