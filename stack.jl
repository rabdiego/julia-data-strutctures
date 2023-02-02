mutable struct Node
    key::Union{Int64, Float64}
    next::Union{Node, Nothing}
end

mutable struct Stack
    top::Union{Node, Nothing}
end

function newStack()::Stack
    return Stack(nothing)
end

function printStack(stack::Union{Stack, Nothing})
    if isnothing(stack.top)
        println("[]")
    else
        aux = stack.top
        print("[$(aux.key)")
        while !isnothing(aux.next)
            aux = aux.next
            print(", $(aux.key)")
        end
        println("]")
    end
end

function push(stack::Union{Stack, Nothing}, key::Union{Int64, Float64})::Stack
    aux::Node = Node(key, stack.top)
    stack.top = aux
    return stack
end

function pop(stack::Union{Stack, Nothing})::Stack
    if isnothing(stack.top)
        println("Error: Underflow")
    else
        stack.top = stack.top.next
    end
    return stack
end
