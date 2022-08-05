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


end

n1 = PolyTreeNode.new('root1')
n2 = PolyTreeNode.new('root2')
n3 = PolyTreeNode.new('root3')




