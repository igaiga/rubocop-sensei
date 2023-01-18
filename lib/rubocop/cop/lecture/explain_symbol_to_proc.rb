# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # foo.bar(&:baz) は次のコードと同じです。
      #
      # foo.bar do |x|
      #   x.baz
      # end
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
      class ExplainSymbolToProc  < Base
        MSG = <<~STRING
          foo.bar(&:baz) は次のコードと同じです。

          foo.bar do |x|
            x.baz
          end
        STRING

        def on_send(node)
          block_pass_potential_node = node.arguments.first
          if block_pass_potential_node &&
             block_pass_potential_node.type == :block_pass &&
             block_pass_potential_node.child_nodes.first.sym_type?
            add_offense(node)
          end
        end
      end
    end
  end
end
