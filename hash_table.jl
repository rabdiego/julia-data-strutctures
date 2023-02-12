function hashFunction(value::Int)::Int
    key::Int = value % 10
    if key == 0
        key = 10
    end
    return key
end

mutable struct Node
    key::Int
    next::Union{Node, Nothing}
end

function newNode(key::Int)::Node
    return Node(key, nothing)
end

function insertNode(N::Union{Node, Nothing}, key::Int)::Node
    x = N
    if isnothing(x)
        N = newNode(key)
    else
        while !isnothing(x.next)
            x = x.next
        end
        x.next = newNode(key)
    end
    return N
end

mutable struct HashTable
    table::AbstractVector{Union{Node, Nothing}}
end

function newHashTable()
    return HashTable(Array{Union{Node, Nothing}}(nothing, 10))
end

function printLine(i::Int, N::Union{Node, Nothing})
    print("Key: $(i) | Value(s): ")
    if isnothing(N)
        println("nothing")
    else
        print("[$(N.key)")
        aux::Union{Node, Nothing} = N.next
        while !isnothing(aux)
            print(", $(aux.key)")
            aux = aux.next
        end
        println("]")
    end
end

function printTable(H::HashTable)
    for i in 1:10
        printLine(i, H.table[i])
    end
end

function insertHT(H::HashTable, value::Int)::HashTable
    key::Int = hashFunction(value)
    H.table[key] = insertNode(H.table[key], value)
    return H
end
