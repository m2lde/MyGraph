function buildconnectedgraph!(v::Array, f::Function, G::DictGraph)
    length(v) <= 1 && return
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = f(x,u))
    end
    buildconnectedgraph!(G,v,f)
end

function buildconnectedgraph(v::Array, f::Function = x -> 1, G::DictGraph = DictGraph())
    length(v) <= 1 && return G
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = f(x,u))
    end
    buildconnectedgraph(v,f,G)
end
