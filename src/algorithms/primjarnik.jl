function mstprimjarnik(G::DictGraph; source = 0)::Tuple{SortedDict{Int, Array{Int,1}},PriorityQueue{Int, Int}}
    𝐷 = SortedDict{Int, Array{Int,1}}(i => [typemax(Int), -1] for i in keys(G.relation))
    𝒬 = PriorityQueue{Int, Int}(i => typemax(Int) for i in vertices(G))

    𝐷[source][1] = 0
    𝒬[source] = 0

    while !isempty(𝒬)
        𝑢 = dequeue_pair!(𝒬)
        for ℒ in G[𝑢.first]                    #for each source adj to 𝑢
            if ℒ[1] ∈ keys(𝒬) && ℒ[2] < 𝒬[ℒ[1]]
                𝐷[ℒ[1]][2] = 𝑢.first;
                𝐷[ℒ[1]][1] = ℒ[2]
                𝒬[ℒ[1]] = ℒ[2]
            end
        end
    end

    #create a new digraph T where T is a spanning tree.
    𝑇 = DictGraph(directed = true)

    for p in 𝐷
        p.first != source && addedge!(𝑇, p.second[2], p.first; weight = p.second[1])
    end

    (𝐷,𝑇)
end
