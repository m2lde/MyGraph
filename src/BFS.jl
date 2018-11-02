function BFS(g::DictGraph, 𝑠::Int)
    bsfDict = SortedDict(i => [-1, typemax(Int), -1] for i in keys(g.relation))
    bsfDict[𝑠] = [0, 0, -1]

    𝑄 = Array{Int, 1}()

    push!(𝑄, 𝑠)

    while !isempty(𝑄)                                       #while the stack is not empty
        𝑢 = pop!(𝑄)

        for 𝑣 in g.relation[𝑢]                              #for each vertex v that belongs to G.Adj[u]
            if bsfDict[𝑣.u][1] == -1
                bsfDict[𝑣.u][1] = 0
                bsfDict[𝑣.u][2] = bsfDict[𝑢][2] + 1
                bsfDict[𝑣.u][3] = 𝑢
                push!(𝑄, 𝑣.u)
            end
        end
        bsfDict[𝑢][1] = 1
    end

    return bsfDict
end

function BFSv2(g::DictGraph, 𝑠::Int)
    bsfDict = SortedDict(i => [-1, typemax(Int), -1] for i in keys(g.relation))
    bsfDict[𝑠] = [0, 0, -1]

    𝑄 = Array{Int, 1}()

    push!(𝑄, 𝑠)

    while !isempty(𝑄)                                       #while the stack is not empty
        𝑢 = pop!(𝑄)

        for 𝑣 in g.relation[𝑢]                              #for each vertex v that belongs to G.Adj[u]
            if bsfDict[𝑣.u][2] == typemax(Int)
                bsfDict[𝑣.u][1] = 0
                bsfDict[𝑣.u][2] = bsfDict[𝑢][2] + 1
                bsfDict[𝑣.u][3] = 𝑢
                push!(𝑄, 𝑣.u)
            end
        end
        
        bsfDict[𝑢][1] = 1
    end
end
