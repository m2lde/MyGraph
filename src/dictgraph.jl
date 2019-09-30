abstract type AbstractGraph end

mutable struct DictGraph <: AbstractGraph
    label::String
    isdirected::Bool
    isweighted::Bool
    numvertices::UInt
    numedges::UInt
    vvwr::Dict{UInt,Dict{UInt,Real}} #vertex => {(vertex,weight),...} relation
end

function DictGraph(label::String; isdirected = false, isweighted = false, vvwr = Dict{UInt, Dict{UInt,Real}}())
    DictGraph(label, isdirected, isweighted, 0, 0, vvwr)
end

function DictGraph(G::DictGraph)
    DictGraph(G.label,G.isdirected, G.isweighted, G.numvertices, G.numedges, Dict(G.vvwr))
end

#Basic operations over graph.
vertices(G::DictGraph) = collect(keys(G.vvwr))

function addvertex!(G::DictGraph, v::Int) :: Nothing
    haskey(G.vvwr, v) || (G[v] = Dict{UInt,Real}())
    G.numvertices += 1
end

function addvertex!(G::DictGraph, vertices::Vararg{UInt,N} where N)
    for vertex in vertices
        addvertex!(G,vertex)
    end
end

function addvertex(G::DictGraph, v::Int)::DictGraph
    T = DictGraph(G)
    addvertex!(T, v)
    T
end

function addvertex(G::DictGraph, vertices::Vararg{UInt, N} where N)::DictGraph
    T = DictGraph(G)
    addvertex!(T,vertices...)
    T
end

function rmvertex!(G::DictGraph, v::UInt) :: Nothing
    try
        G[v];
        for k in vertices(G)
            k != v && delete!(G[k],v)
        end

        #delete vertex
        delete!(G.vvwr, v)
        G.numvertices -= 1
    catch e
        if isa(e, KeyError)
            println("vertex $v does not belongs to this graph.")
        else
            error("G: unknown error.")
        end
    end # try
end

function rmvertex!(G::DictGraph, vertices::Vararg{UInt, N} where N)::Nothing
    foreach(vertex -> rmvertex!(G,vertex), vertices)
end

function rmvertex(G::DictGraph, v::Int)::DictGraph
    T = DictGraph(G)
    rmvertex!(T,v)
    T
end

function rmvertex(G::DictGraph, vertices::Vararg{UInt,N} where N)::DictGraph
    T = DictGraph(G)
    rmvertex!(T,vertices...)
    T
end

function addedge!(G::DictGraph, source::Int, target::Int; weight::Real = 1.0) :: Nothing
    addvertex!(G, source)
    addvertex!(G, target)
    push!(G[source], target => weight)
    !G.isdirected && push!(G[target], source => weight)
    G.numedges += 1
end

function addedge!(G::DictGraph, edge::Tuple{UInt,UInt,Real})::Nothing
    addedge!(G,edge[1],edge[2]; weight = edge[3])
end

function addedge!(G::DictGraph, edges::Vararg{Tuple{UInt,UInt,Real}, N} where N)::Nothing
    foreach(edge -> addedge!(G,edge), edges)
end

function addedge(G::DictGraph, source::Int, target::Int; weight::Real = 1.0)::DictGraph
    T = DictGraph(G);
    addedge!(T, v, u; weight = weight);
    T
end

function addedge(G::DictGraph, edges::Vararg{Tuple{UInt,UInt,Real}, N} where N)::DictGraph
    T = DictGraph(G)
    addedge!(T,edges...)
    T
end

function getindex(G::DictGraph, i::Int)
    return G.vvwr[i]
end

function getedgeweight(G::DictGraph, source::Int, target::Int)::Real
    !G.isweighted || error("Graph is not weghted.")
    haskey(G.vvwr, source) || error("vertex $source does not belongs to this graph.")
    haskey(G.vvwr, source) || error("vertex $target does not belongs to this graph.")
    G[source][target]
end

function lowestweightedge(G::DictGraph, vertex::Int, only::Vararg{Int,N} where N)::Pair{Int, Real}
    !G.isweighted || error("Graph $(G.label) is not weghted.")
    haskey(G.vvwr) || error("the vertex $vertex does not belongs to this graph.")
    E = Set(only)
    foreach(e -> haskey(G[e]) || error("the vertex $vertex does not belongs to this graph."), S)
    t = Pair(-1, Inf32);
    for kv in G[vertex]
         kv[1] ∈ E && kv[2] < t[2] && (t = kv)
    end
    t
end

function minweightedge(G::DictGraph)::Pair{Real, Tuple{Int,Int}}
    D = Array{Pair{Real, Tuple{Int,Int}}}()
    for v in vertices(G)
        x = minweightedgefromvertex(G,v)
        push!(D, x[2] => (v, x[1]))
    end
    min(D)
end
