function buildconnectedgraph!(v::Array, G::DictGraph; f::Function = (a,b) -> 1)
    length(v) <= 1 && return
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = f(x,u))
    end
    buildconnectedgraph!(v,G;f = f)
end

function buildconnectedgraph(v::Array, G::DictGraph = DictGraph(); f::Function = (a,b) -> 1)
    length(v) <= 1 && return G
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = f(x,u))
    end
    buildconnectedgraph(v,G; f = f)
end
