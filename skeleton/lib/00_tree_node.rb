class PolyTreeNode

    attr_reader :parent, :children, :value
    attr_writer :children

    def initialize(value)
        @parent = nil
        @children = []
        @value = value
    end

    def parent=(node)
        if node == nil
            @parent = nil
            return
        end

        if parent
            @parent.children.delete(self)
        end

        @parent = node
        node.children << self
    end

    def add_child(child_node)
        child_node.parent= self
    end

    def remove_child(child_node)
        raise "Not a child" if !child_node.parent
        child_node.parent= nil
    end

    def dfs(target_value)
        return nil if self == nil
        return self if self.value == target_valuef
        children.each do |child|
            result = child.dfs(target_value)

            return result if result && result.value == target_value
        end
        nil
    end

end

n1 = PolyTreeNode.new('root1')
n2 = PolyTreeNode.new('root2')
n3 = PolyTreeNode.new('root3')




