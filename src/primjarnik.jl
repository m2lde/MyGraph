function mstprimjarnik(G::DictGraph; source = 0)
    𝐷 = SortedDict{Int, Array{Int,1}}(i => [typemax(Int), -1] for i in keys(G.relation))
    𝒬 = PriorityQueue{Int, Int}(i => typemax(Int) for i in keys(G.relation))

    𝐷[source][1] = 0
    𝒬[source] = 0

    while !isempty(𝒬)
        𝑢 = dequeue_pair!(𝒬)
        for ℒ in G.relation[𝑢.first]                    #for each source adj to 𝑢
            if ℒ.u ∈ keys(𝒬) && ℒ.w < 𝒬[ℒ.u]
                𝐷[ℒ.u][2] = 𝑢.first; 𝐷[ℒ.u][1] = ℒ.w
                𝒬[ℒ.u] = ℒ.w
            end
        end
    end

    #create a new digraph T where T is a spanning tree.
    𝑇 = DictGraph(directed = true)

    for p in 𝐷
        p.first != source && addedge!(𝑇, p.second[2], p.first; weight = p.second[1])
    end

    return 𝐷,𝑇
end
