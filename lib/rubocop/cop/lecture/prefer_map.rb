# frozen_string_literal: true

require "typeprof"

module RuboCop
  module Cop
    module Lecture
      # `each`メソッドは`map`メソッドで置き換えられることがあります。
      # eachメソッドの結果、Arrayを得ているときはmapで書き換え可能かを検討してみてください。
      #
      # @example
      #   # bad
      #   result = []
      #   [1,2,3].each do |x|
      #     result << x * 2
      #   end
      #
      #   # good
      #   [1,2,3].map do |x|
      #     x * 2
      #   end
      #
      class PreferMap < Base
        MSG = <<~STRING
          この`each`メソッドは`map`メソッドで置き換えられるかもしれません。
        STRING

        # TODO: auto correct
        def on_block(node)
          return unless node.child_nodes.any?{|x| x.respond_to?(:method_name) && x.method_name == :each}

          # mapに書き換え可能そうか
          begin
            map_potential_methods = [:<<, :push, :unshift]
            node.
              child_nodes.
              select{|x| x.respond_to?(:method_name)}.
              select{|x| map_potential_methods.include?(x.method_name) }.each do |map_potential_method_node|

              ## map_potential_methodsのレシーバの型がArrayであるかどうかをTypeProfで調査
              receiver_variable_name = node.child_nodes.last.receiver.node_parts.first.to_s
              rb_text = node.parent.source
              rb_text += "\np #{receiver_variable_name}" # TypeProf調査行
              target_line_number = rb_text.lines.count
              rb_files = [["target.rb", rb_text]]
              rbs_files = []

              output = StringIO.new(String.new("")) # make mutable String object
              options = { show_errors: true }
              config = TypeProf::ConfigData.new(rb_files: rb_files, rbs_files: rbs_files, output: output, max_sec: 5, options: options)
              TypeProf.analyze(config)
              #=> "# TypeProf 0.21.4\n\n# Revealed types\n#  target.rb:6 #=> Array[Integer]\n\n# Classes\n"
              expected_type = output.string.match(/target.rb:#{target_line_number}\s*#=>\s*(.+)$/).captures.first
              #=> Array[SomeClass] or untyped or somethings
              if expected_type.match(/(.+)\[.+\]/).captures.first == "Array"
                add_offense(node)
                return
              end
            end
          rescue => e
            # 解析失敗
            # p e
          end
        end
      end
    end
  end
end
