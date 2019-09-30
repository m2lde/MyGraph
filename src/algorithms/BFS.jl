function BFS(G::DictGraph, start::Int)::SortedDict
    bsfDict = SortedDict(i => [-1, typemax(Int), -1] for i in keys(G.relation))
    bsfDict[start] = [0, 0, -1]

    𝑄 = Array{Int, 1}()

    push!(𝑄, start)

    while !isempty(𝑄)
        𝑢 = pop!(𝑄)
        for 𝑣 in G[𝑢]
            if bsfDict[𝑣[1]][1] == -1
                bsfDict[𝑣[1]][1] = 0
                bsfDict[𝑣[1]][2] = bsfDict[𝑢][2] + 1
                bsfDict[𝑣[1]][3] = 𝑢
                push!(𝑄, 𝑣.u)
            end
        end
        bsfDict[𝑢][1] = 1
    end

    return bsfDict
end

function BFSv2(G::DictGraph, start::Int)::SortedDict
    bsfDict = SortedDict(i => [-1, typemax(Int), -1] for i in keys(G.relation))
    bsfDict[start] = [0, 0, -1]

    𝑄 = Array{Int, 1}()

    push!(𝑄, start)

    while !isempty(𝑄)                                       #while the stack is not empty
        𝑢 = pop!(𝑄)

        for 𝑣 in G[𝑢]                              #for each vertex v that belongs to G.Adj[u]
            if bsfDict[𝑣[1]][2] == typemax(Int)
                bsfDict[𝑣[1]][1] = 0
                bsfDict[𝑣[1]][2] = bsfDict[𝑢][2] + 1
                bsfDict[𝑣[1]][3] = 𝑢
                push!(𝑄, 𝑣[1])
            end
        end

        bsfDict[𝑢][1] = 1
    end
end
