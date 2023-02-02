mutable struct Node
    key::Union{Int64, Float64}
    parent::Union{Node, Nothing}
    left::Union{Node, Nothing}
    right::Union{Node, Nothing}
end

mutable struct BinarySearchTree
    root::Union{Node, Nothing}
end

function newTree()::BinarySearchTree
    return BinarySearchTree(nothing)
end

function insert(T::BinarySearchTree, key::Union{Int64, Float64})::BinarySearchTree
    aux = Node(key, nothing, nothing, nothing)

    if isnothing(T.root)
        T.root = aux
    else
        x::Union{Node, Nothing} = T.root
        y::Union{Node, Nothing} = nothing

        while !isnothing(x)
            y = x
            if key > x.key
                x = x.right
            else
                x = x.left
            end
        end

        aux.parent = y
        if key > y.key
            y.right = aux
        else
            y.left = aux
        end
    end

    return T
end

function treeMinimum(T::BinarySearchTree)::Node
    if isnothing(T.root)
        println("Empty tree")
    else
        aux = T.root
        while !isnothing(aux.left)
            aux = aux.left
        end
        return aux
    end
end

t = newTree()
t = insert(t, 3)
t = insert(t, 5)
t = insert(t, 2)
println("$(treeMinimum(t))")

