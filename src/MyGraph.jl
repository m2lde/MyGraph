__precompile__()

module MyGraph

import Base: ==, isless, getindex, setindex!, isempty, isequal

        #structs
export  Graph, DictGraph, Link,
        #functions
        delvertex, delvertex!, addedge, addedge!, addvertex, addvertex!,
        vertices, buildconnectedgraph!,
        buildconnectedgraph, getweight, minweight, minweightdict,
        #algotihms
        DFS, BFS, BFSv2, printpath, sortededgesbyweight,
        mstkruskal, mstprimjarnik, dijkstra, makecirclepath,
        #macros
        @buildgraph

using   DataStructures

include("link.jl")
include("dictgraph.jl")
include("dijkstra.jl")
include("connectedgraph.jl")
include("DFS.jl")
include("BFS.jl")
include("printpath.jl")
include("buildgraph.jl")
include("kruskal.jl")
include("primjarnik.jl")
include("alg1.jl")

end #module → ↔
