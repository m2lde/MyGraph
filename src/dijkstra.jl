
function dijkstra(G::DictGraph; source::Int = 0, target::Int = -1)
    Q = PriorityQueue{Int,Real}(v => typemax(Int) for v in vertices(G))
    D = SortedDict{Int, Array{Real, 1}}(v => [typemax(Int), -1] for v in vertices(G))

    Q[source] = 0
    D[source][1] = 0

    function relax(u,v,w)
        if D[v][1] > D[u][1] + w
            D[v][1] = D[u][1] + w; Q[v] = D[u][1] + w;
            D[v][2] = u
        end
    end

    while !isempty(Q)
        u = dequeue_pair!(Q)
        u.first == target && break
        for ℒ in G[u.first]
            relax(u.first, ℒ.u, ℒ.w)
        end
    end

    return D
end
