abstract type AbstractGraph end

mutable struct DictGraph <: AbstractGraph
    isdirected::Bool
    isweighted::Bool
    numvertices::UInt
    numedges::UInt
    vvwr::Dict{UInt,Dict{UInt,Float32}} #vertex => {(vertex,weight),...} relation
end

function DictGraph(;isdirected = false, isweighted = false, vvwr = Dict{UInt, Dict{UInt,Float32}}())
    DictGraph(isdirected, isweighted, 0, 0, vvwr)
end

function DictGraph(G::DictGraph)
    DictGraph(G.isdirected, G.isweighted, G.numvertices, G.numedges, Dict(G.vvwr))
end

#Basic operations over graph.
vertices(G::DictGraph) = collect(keys(G.vvwr))

function addvertex!(G::DictGraph, v::Int) :: Nothing
    haskey(G.vvwr, v) || (G[v] = Dict{UInt,Float32}())
    G.numvertices += 1
end

function addvertex(G::DictGraph, v::Int)::DictGraph
    T = DictGraph(G)
    addvertex!(T, v)
    T
end

function delvertex!(G::DictGraph, v::Int) :: Nothing
    haskey(G.vvwr, v) || error("vertex $v does not belongs to this graph.")

    #remove all edges
    for k in vertices(G)
        k != v && delete!(G[k],v)
    end

    #delete vertex
    delete!(G.vvwr, v)
    G.numvertices -= 1
end

function delvertex(G::DictGraph, v::Int)::DictGraph
    T = DictGraph(G)
    delvertex!(T,v)
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

function addedge!(G::DictGraph, edges::Vararg{Tuple{UInt,UInt,Real},N} where N)::Nothing
    for edge in edges
        addedge!(G,edge)
    end
end

function addedge(G::DictGraph, v::Int, u::Int; weight::Real = 1.0) :: DictGraph
    T = DictGraph(G);
    addedge!(T, v, u; weight = weight);
    T
end

function getindex(G::DictGraph, i::Int)
    return G.vvwr[i]
end

function getedgeweight(G::DictGraph, source::Int, target::Int)::Float32
    !G.isweighted || error("Graph is not weghted.")
    haskey(G.vvwr, source) || error("vertex $source does not belongs to this graph.")
    haskey(G.vvwr, source) || error("vertex $target does not belongs to this graph.")
    G[source][target]
end

function minweightedgefromvertex(G::DictGraph, vertex::Int, restrict::Vararg{Int,N} where N)::Pair{Int, Float32}
    !G.isweighted || error("Graph is not weghted.")
    haskey(G[vertex]) || error("vertex $vertex does not belongs to this graph.")

    S = Set(restrict)
    t = Pair(-1, Inf32);
    for kv in G[vertex]
         (kv[2] < t && !(kv[1] ∈ S)) && (t = kv)
    end
    t
end

function minweightedge(G::DictGraph)::Pair{Float32, Tuple{Int,Int}}
    D = Array{Pair{Float32, Tuple{Int,Int}}}()
    for v in vertices(G)
        x = minweightedgefromvertex(G,v)
        push!(D, x[2] => (v, x[1]))
    end
    min(D)
end
