function DFSVisit(G::DictGraph, dfsDict::SortedDict, u::Int, t::Int)
    t  += 1;
    dfsDict[u][2] = t;
    dfsDict[u][1] = 0;

    for v in G.relation[u]
        if dfsDict[v.u][1] == -1
            dfsDict[v.u][3] = u
            DFSVisit(G, dfsDict, v.u, t);
        end
    end

    dfsDict[u][1] = 1
    t += 1
    dfsDict[u][4] += t

    return;
end

function DFS(G::DictGraph; s::Int = -1)
    dfsDict = SortedDict(i => [-1 0 -1 0] for i in keys(G.relation))
    #                         [c  d  π f]
    t = -1

    if s > -1
        s in keys(G) || error("$v is not a vertex of this graph.")
        DFSVisit(G, dfsDict, s, t)
    end

    for v in keys(G.relation)
        dfsDict[v][1] == -1 && DFSVisit(G, dfsDict, v, t)
    end

    return dfsDict
end
