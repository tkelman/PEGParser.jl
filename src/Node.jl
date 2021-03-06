# include("EBNF.jl")

immutable Node
  name::String
  value::String
  first::Int
  last::Int
  children::Array #::Array{Node}
  ruleType::Type
  sym::Any

  function Node(node::Node)
    return new(node.name, node.value, node.first, node.last, node.children, node.ruleType, node.sym)
  end

  function Node(name::String, value::String, first::Int, last::Int, children::Array, ruleType::Type)
    if length(name) == 0
      sym = nothing
    else
      sym = symbol(name)
    end

    return new(name, value, first, last, children, ruleType, sym)
  end
end

function Node(name::String, value::String, first::Int, last::Int, typ)
  return Node(name, value, first, last, [], typ)
end

function show{T}(io::IO, val::T, indent)
  println(io, "$val ($(typeof(val)))")
end

function show(io::IO, node::Node, indent)
  println(io, "node($(node.name)) {$(displayValue(node.value, node.ruleType))$(node.ruleType)}")
  if isa(node.children, Array)
    for (i, child) in enumerate(node.children)
      print(io, "  "^indent)
      print(io, "$i: ")
      show(io, child, indent+1)
    end
  else
    print(io, "  "^(indent+1))
    show(io, node.children, indent+1)
  end
end

function show(io::IO, node::Node)
    show(io, node, 0)
end
