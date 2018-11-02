macro buildgraph(directed::Bool, edges...)
    G = DictGraph(isDirected = directed)
    count = 0
    for e in edges
        count += 1
        length(e.args) >  3 && error("invalid edge")
        if length(e.args) == 2
            @assert !(typeof(e.args[1]) != Int || typeof(e.args[2]) != Int) "invalid edge. the type of the vertices must be Intger values."
            addedge!(G, e.args[1], e.args[2])
            continue
        end
        if length(e.args) == 3
            @assert !(typeof(e.args[1]) != Int || typeof(e.args[2]) != Int || typeof(e.args[3]) != Int) "invalid edge. the type of the vertices and weights must be Integer values."
            addedge!(G, e.args[1], e.args[2]; weight = e.args[3])
        end
    end
    return G
end
