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

function treeMinimum(T::BinarySearchTree)::Union{Node, Nothing}
    if isnothing(T.root)
        aux = nothing
    else
        aux = T.root
        while !isnothing(aux.left)
            aux = aux.left
        end
    end
    return aux
end

function nextNode(N::Node)::Union{Node, Nothing}
    aux = nothing
    if !isnothing(N.right)
        auxTree = BinarySearchTree(N.right)
        aux = treeMinimum(auxTree)
    else
        if !isnothing(N.parent)
            x = N
            y = N.parent
            while y !== nothing && y.left != x
                y = y.parent
                x = x.parent
            end
            aux = y
        end
    end
    return aux
end

function printTree(T::Union{BinarySearchTree, Nothing})
    if isnothing(T.root)
        println("[]")
    else
        aux::Union{Node, Nothing} = treeMinimum(T)
        print("[$(aux.key)")
        while nextNode(aux) !== nothing
            aux = nextNode(aux)
            print(", $(aux.key)")
        end
        println("]")
    end
end

t = newTree()
t = insert(t, 3)
t = insert(t, 5)
t = insert(t, 2)
printTree(t)


