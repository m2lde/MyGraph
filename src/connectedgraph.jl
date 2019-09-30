function buildconnectedgraph!(v::Array{Int,1}, G::DictGraph; weightfunction::Function = (a,b) -> 1)
    length(v) <= 1 && return
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = weightfunction(x,u))
    end
    buildconnectedgraph!(v,G; weightfunction = weightfunction)
end

function buildconnectedgraph(v::Array{Int,1}, G::DictGraph = DictGraph(); weightfunction::Function = (a,b) -> 1)
    length(v) <= 1 && return G
    x = pop!(v)
    for u in v
        addedge!(G, x, u; weight = weightfunction(x,u))
    end
    buildconnectedgraph(v,G; weightfunction = weightfunction)
end
