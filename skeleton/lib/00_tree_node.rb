require 'byebug'
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
        return self if self.value == target_value
        children.each do |child|
            result = child.dfs(target_value)

            return result if result && result.value == target_value
        end
        nil
    end



    def bfs(target_value)
        queue = [self] # [1]
        until queue.empty? #[tree is empty]
            node = queue.shift
            if node == target_value
                return node
            else 
                queue.push(node.children)
            end

        end
    end

    def inspect #defining when you print it what 
        @value
        # @children.inspect
    end

end


# tree_1 = PolyTreeNode.new(6)
# tree_kid = PolyTreeNode.new(7)
# tree_1.add_child(tree_kid)

# p tree_1





