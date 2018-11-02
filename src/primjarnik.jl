function mstprimjarnik(G::DictGraph; vertex = 0)
    𝐷 = SortedDict{Int, Array{Int,1}}(i => [typemax(Int), -1] for i in keys(G.relation))
    𝒞 = PriorityQueue{Int, Int}(i => typemax(Int) for i in keys(G.relation))
    𝑇 = DictGraph()

    𝐷[vertex][1] = 0
    𝒞[vertex] = 0

    while !isempty(𝒞)
        𝑢 = dequeue_pair!(𝒞)
        for 𝔏 in G.relation[𝑢.first]                    #for each vertex adj to 𝑢
            if 𝔏.u ∈ keys(𝒞) && 𝔏.w < 𝒞[𝔏.u]
                #println("($(𝑢.first), $(𝔏.u), $(𝔏.w))")
                𝐷[𝔏.u][1] = 𝑢.first; 𝐷[𝔏.u][2] = 𝔏.w
                𝒞[𝔏.u] = 𝔏.w
            end
        end
    end

    for p in 𝐷
        p.first != vertex && addedge!(𝑇, p.first, p.second[1]; weight = p.second[2])
    end

    return 𝐷,𝑇
end
