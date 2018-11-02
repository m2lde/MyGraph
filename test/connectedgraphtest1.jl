using MyGraph

G = DictGraph()

buildconnectedgraph!(collect(1:6), (a,b) -> first(abs.(rand(Int16, 1))), G)

D1 = dijkstra(G;source = 1)
D2 = dijkstra(G;source = 2)
D3 = dijkstra(G;source = 3)
D4 = dijkstra(G;source = 4)
D5 = dijkstra(G;source = 5)
D6 = dijkstra(G;source = 6)
