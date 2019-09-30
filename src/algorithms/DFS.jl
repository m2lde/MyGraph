function DFSVisit(G::DictGraph, dfsDict::SortedDict, vertex::Int, count::Int)
    count  += 1;
    dfsDict[vertex][2] = t;
    dfsDict[vertex][1] = 0;

    for v in G[vertex]
        if dfsDict[v[1]][1] == -1
            dfsDict[v[1]][3] = vertex
            DFSVisit(G, dfsDict, v[1], count);
        end
    end

    dfsDict[vertex][1] = 1
    count += 1
    dfsDict[vertex][4] += count

    return;
end

function DFS(G::DictGraph; vertex::Int = -1)
    dfsDict = SortedDict(i => [-1 0 -1 0] for i in keys(G.relation))
    #                         [c  d  π f]
    count = -1

    if vertex > -1
        vertex in keys(G) || error("$vertex is not a vertex of this graph.")
        DFSVisit(G, dfsDict, vertex, count)
    end

    for v in keys(G.relation)
        dfsDict[v][1] == -1 && DFSVisit(G, dfsDict, v, count)
    end

    return dfsDict
end
