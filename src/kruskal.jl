#=

=#
function sortededgesbyweight(G::DictGraph)
    @assert !G.directed "the graph must be undirected"
    𝑄 = PriorityQueue{Tuple{Int,Int}, Int}()
    for k in keys(G.relation)
        for link in G.relation[k]
            local t = (k, link.u)
            (!haskey(𝑄, t) && !haskey(𝑄, reverse(t))) && push!(𝑄, t => link.w)
        end
    end
    return 𝑄

end

function mstkruskal(G::DictGraph)
    T = DictGraph()
    Q = sortededgesbyweight(G)
    DS = IntDisjointSets(length(G.relation))

    while !isempty(Q)
        e = dequeue_pair!(Q)
        if !in_same_set(DS, e.first[1] + 1, e.first[2] + 1)
            union!(DS, e.first[1] + 1, e.first[2] + 1)
            addedge!(T, e.first[1], e.first[2]; weight = e.second)
        end
    end

    return T
end
