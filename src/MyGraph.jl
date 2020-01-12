__precompile__()

module MyGraph

using DataStructures, LightGraphs

import Base: ==, isless, getindex, setindex!, isempty, isequal, eltype

import LightGraphs: AbstractGraph, edgetype,has_edge,has_vertex,inneighbors,ne,
                    nv,outneighbors,vertices,is_directed

export  AbstractDictGraph,
        DictGraph

abstract type AbstractDictGraph{V,E} <: AbstractGraph{V} end

mutable struct DictGraph{V,E} <: AbstractDictGraph{V,E}
    is_directed::Bool
    is_weighted::Bool
    numvertices::Int
    numedges::Int
    vvwr::Dict{V,Dict{V,E}} #vertex => {(vertex,weight),...} relation

    function DictGraph{V,E}(;isdirected = false, isweighted = false, vvwr = Dict{V, Dict{V,E}}()) where {V,E}
        new{V,E}(isdirected, isweighted, 0, 0, vvwr)
    end
end

function DictGraph(G::DictGraph)
    DictGraph(G.isdirected, G.isweighted, G.numvertices, G.numedges, Dict(G.vvwr))
end

#Basic operations over graph.
vertices(G::AbstractDictGraph) = collect(keys(G.vvwr))

function add_vertex!(G::AbstractDictGraph{V,E}, vertices::Vararg{V,N} where N) :: Nothing where {V,E}
    for vertex in vertices
        (!haskey(G.vvwr, vertex) && push!(G.vvwr, vertex => Dict{V,E}())) && G.numvertices += 1
    end
    nothing
end

function add_vertex(G::AbstractDictGraph{V,E}, vertices::Vararg{UInt, N} where N)::DictGraph where {V,E}
    T::DictGraph = DictGraph(G)
    add_vertex!(T,vertices...)
    T
end



function rem_vertex!(G::AbstractDictGraph{V,E}, vertices::Vararg{V,N} where N)::Nothing where {V,E}
    function remvertex!(G::AbstractDictGraph{V,E}, vertex::V) :: Nothing where {V,E}
        try
            G[v];
            for k in vertices(G)
                k != v && delete!(G[k],v)
            end

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
    foreach(vertex -> remvertex!(G,vertex), vertices)
end



function rem_vertex(G::DictGraph, vertices::Vararg{UInt,N} where N)::DictGraph
    T = DictGraph(G)
    rem_vertex!(T,vertices...)
    T
end

function addedge!(G::DictGraph, source::Int, target::Int; weight::Real = 1.0) :: Nothing
    add_vertex!(G, source)
    add_vertex!(G, target)
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


include("connectedgraph.jl")
#algorihms
include("algorithms/dijkstra.jl")
include("algorithms/DFS.jl")
include("algorithms/BFS.jl")
include("algorithms/printpath.jl")
include("algorithms/kruskal.jl")
include("algorithms/primjarnik.jl")
include("algorithms/alg1.jl")

end #module → ↔
