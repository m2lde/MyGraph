abstract type AbstractGraph end

mutable struct DictGraph <: AbstractGraph
    isDirected::Bool
    relation::SortedDict{Int,SortedSet{Link}}

    DictGraph(;isDirected = false, relation = SortedDict{Int,SortedSet{Link}}()) = new(isDirected, relation)
    function DictGraph(G::DictGraph)
        S = SortedDict(G.relation); b= G.isDirected;
        new(S, b)
    end
end #Graph

vertices(G::DictGraph) = collect(keys(G.relation))

function delvertex!(G::DictGraph, v::Int) :: Nothing
    haskey(G.relation, v) || error("vertex $v not found.")

    #remove all edges
    for k in vertices(G)
        k == v && continue
        S = SortedSet{Link}();
        for l in G[k]
            l.u != v && push!(S, l)
        end
        G.relation[k] = S
    end
    #delete vertex
    delete!(G.relation, v)
    nothing
end

function delvertex(G::DictGraph, v::Int)
    T = DictGraph(G)
    delvertex!(T,v)
    return T
end

function addedge!(G::DictGraph, v::Int, u::Int; weight::Real = 1.0) :: Nothing
    haskey(G.relation, v) || push!(G.relation, v => SortedSet{Link}())
    haskey(G.relation, u) || push!(G.relation, u => SortedSet{Link}())

    if G.isDirected
        push!(G.relation[v], Link(u,weight))
    else
        push!(G.relation[v], Link(u,weight))
        push!(G.relation[u], Link(v,weight))
    end
    nothing
end

function addedge(G::DictGraph, v::Int, u::Int; weight::Real = 1.0) :: DictGraph
    w = weight;T = G; addedge!(T, v, u; weight = w);
    return T
end

function getindex(G::DictGraph, i::Int)
    return G.relation[i]
end

function getweight(G::DictGraph, s::Int, t::Int)
    for ℒ in G[s]
        ℒ.u == t && (return ℒ.w)
    end
end

function minweight(G::DictGraph, vertex::Int; restrict = Set{Int}())
    ℒ = Link(-1, 0.0); t = Inf;
    for link in G[vertex]
         (link.w < t && !(link.u in restrict)) && (ℒ = link; t = link.w)
     end
     return ℒ
end

function minweightdict(G::DictGraph)
    D = SortedDict{Int,Link}()
    for v in keys(G)
        push!(D, v => minweight(G, v))
    end
    return D
end
