#create a path ending at source taking each vertex only one time.
function makecirclepath(G::DictGraph, S = Set{Int}(), T = DictGraph(directed = true); source = 0, ending = 0)
    if length(G.relation) - length(S) <= 1
        l = getweight(G, ending, source)
        addedge!(T, ending, source; weight = l)
        return T, source, ending
    end

    ℒ = minweight(G, ending; restrict = S)
    addedge!(T, ending, ℒ.u; weight = ℒ.w)
    S = S ∪ ending
    makecirclepath(G, S, T; ending = ℒ.u)
end

function makepath(D::AbstractDict, source::Int, target::Int, G::DictGraph = DictGraph(); pred = 2)
    if s == v
        nothing
    elseif d[v][pred] == -1
        error("no path from $s to $v exists.")
    else
        makepath(d, s, d[v][2], G)
        addedge!(G, d[v][2], s; weight = d[v][3])
    end
end

function alg2(G::DictGraph, D::AbstractDict, source::Int, target::Int)

end
