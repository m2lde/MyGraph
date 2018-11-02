function alg1(G::DictGraph, S = Set{Int}(), T = DictGraph(;isDirected = true); source = 0, start = 0)
    if length(G.relation) - length(S) <= 1
        #l = getweight(G, start, source)
        #addEdge!(T, start, source; weight = l)
        return T, start
    end

    ℒ = minweight(G, start; restrict = S)
    addEdge!(T, start, ℒ.u; weight = ℒ.w)
    S = S ∪ start
    alg1(G, S, T; start = ℒ.u)

end
