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
    aux::Node = Node(key, nothing, nothing, nothing)

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
        aux::Union{Node, Nothing} = nothing
    else
        aux = T.root
        while !isnothing(aux.left)
            aux = aux.left
        end
    end
    return aux
end

function nextNode(N::Node)::Union{Node, Nothing}
    aux::Union{Node, Nothing} = nothing
    if !isnothing(N.right)
        auxTree::BinarySearchTree = BinarySearchTree(N.right)
        aux = treeMinimum(auxTree)
    else
        if !isnothing(N.parent)
            x::Node = N
            y::Union{Node, Nothing} = N.parent
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

function treeIndex(T::Union{BinarySearchTree, Nothing}, index::Int64)::Union{Node, Nothing}
    aux::Union{Node, Nothing} = treeMinimum(T)
    if !isnothing(aux)
        i::Int64 = 1
        while aux !== nothing && index != i
            aux = nextNode(aux)
            i += 1
        end
    end
    return aux
end

function transplant(T::BinarySearchTree, u::Union{Node, Nothing}, v::Union{Node, Nothing})::BinarySearchTree
    if isnothing(u.parent)
        T.root = v
    elseif u == u.parent.left
        u.parent.left = v
    else
        u.parent.right = v
    end

    if !isnothing(v)
        v.parent = u.parent
    end
    return T
end

function remove(T::Union{BinarySearchTree, Nothing}, index::Int64)::Union{BinarySearchTree, Nothing}
    z::Union{Node, Nothing} = treeIndex(T, index)
    if isnothing(z)
        println("Overflow")
    else
        if isnothing(z.left)
            T = transplant(T, z, z.right)
        elseif isnothing(z.right)
            T = transplant(T, z, z.left)
        else
            y::Union{Node, Nothing} = nextNode(z)
            T = transplant(T, y, y.right)
            y.left = z.left
            z.left.parent = y
            y.right = z.right
            z.right.parent = y
            T = transplant(T, z, y)
        end
    end
    return T
end
