# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # TODO: 書き換え
      # このブロックはmethod(&:method)で置き換えられるかもしれません。
      #
      # @example
      #   # bad
      #   ["a","b","c"].map do |x|
      #     x.upcase
      #   end
      #
      #   # good
      #   ["a","b","c"].map(&:upcase)
      #
      class PreferSymbolToProc < Base
        # TODO: 追記
        MSG = <<~STRING
          このブロックはmethod(&:method)で置き換えられるかもしれません。
        STRING

        # TODO: auto correct
        def on_block(node)
          target_nodes = node.child_nodes - [node.send_node] # ブロックが渡されている主メソッドは除く
          send_type_nodes = target_nodes.select(&:send_type?) # :begin nodeが入らず、直下にあること
          if send_type_nodes.count == 1 && !send_type_nodes.last.arguments?
            add_offense(node)
          end
        end
      end
    end
  end
end
