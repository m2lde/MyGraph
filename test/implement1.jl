using MyGraph
using DataStructures

G = DictGraph(true)
B = Array{OrderedDict, 1}()
ctr = 0

addEdge!(G,0,2)
addEdge!(G,0,4)
addEdge!(G,0,3)
addEdge!(G,1,1)
addEdge!(G,1,4)
addEdge!(G,1,2)
addEdge!(G,2,4)
addEdge!(G,3,4)
addEdge!(G,3,5)
addEdge!(G,4,5)
addEdge!(G,5,1)
addEdge!(G,5,6)

for v in vertices(G)                        #para cada vertice em G
    push!(B, BFS(G,v))                      #inserir em B o BSF a partir do vertive V
end

for D in B
    local R = Array{Int, 1}()               #Inicializa R
    R = [0 for _ = 1:length(G.relation)]    #Vetor R do tamando da quantidade de verices no grafo.
    for k in keys(D)
        R[k + 1] = D[k][2]
    end
    println("$ctr => $R")
    global ctr += 1
end
