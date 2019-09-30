__precompile__()

module MyGraph

import Base: ==, isless, getindex, setindex!, isempty, isequal

        #structs
export  AbstractGraph, DictGraph,
        #functions
        delvertex, delvertex!, addedge, addedge!, addvertex, addvertex!,
        vertices, buildconnectedgraph!,
        buildconnectedgraph, getweight, minweight, minweightdict,
        #algotihms
        DFS, BFS, BFSv2, printpath, sortededgesbyweight,
        mstkruskal, mstprimjarnik, dijkstra, makecirclepath

using DataStructures

include("dictgraph.jl")
include("connectedgraph.jl")
#algorihms
include("algorithms/dijkstra.jl")
include("algorithms/DFS.jl")
include("algorithms/BFS.jl")
include("algorithms/printpath.jl")
include("algorithms/kruskal.jl")
include("algorithms/primjarnik.jl")
include("algorithms/alg1.jl")

end #module → ↔
