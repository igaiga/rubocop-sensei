# frozen_string_literal: true

module RuboCop
  module Cop
    module Lecture
      # foo.bar{ _1.baz } は foo.bar{|x| x.baz } と同じです。
      # _1と書くことで、||で囲まれたブロック変数を書かずに短く書けます。
      # ナンバーパラメータと呼ばれます。
      # _1, _2, _3, ... と複数書くこともできます。
      # foo.bar{ [_1,_2] } は foo.bar{|x,y| [x,y] }と同じです。
      #
      # @example
      #   # good
      #   foo.bar{ _1.baz }
      #
      #   # good
      #   foo.bar{|x| x.baz }
      #
      class ExplainNumberedParameters < Base
        MSG = <<~STRING
          foo.bar{ _1.baz } は foo.bar{|x| x.baz } と同じです。
          _1と書くことで、||で囲まれたブロック変数を書かずに短く書けます。
          ナンバーパラメータと呼ばれます。
          _1, _2, _3, ... と複数書くこともできます。
          foo.bar{ [_1,_2] } は foo.bar{|x,y| [x,y] }と同じです。
        STRING

        def on_block(node)
          send_nodes = node.child_nodes.select{|n| n.type == :send}
          send_nodes.each{|n| check_send_node_has_numbered_parameter(n)}
        end

        def check_send_node_has_numbered_parameter(node)
          # Check child nodes
          node.child_nodes.select{|n| n.type == :send}.each do |n|
            return :found if check_send_node_has_numbered_parameter(n) == :found
          end

          # Check argument node
          if node.node_parts.any?{|e| e == :_1}
            add_offense(node)
            return :found
          end
        end
      end
    end
  end
end
