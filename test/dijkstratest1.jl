using MyGraph

G = @buildgraph false 1,6,14 1,3,9 1,2,7 2,3,10 2,4,15 3,6,2 3,4,11 4,5,6 5,6,9

D1 = dijkstra(G;source = 1)
D2 = dijkstra(G;source = 2)
D3 = dijkstra(G;source = 3)
D4 = dijkstra(G;source = 4)
D5 = dijkstra(G;source = 5)
D6 = dijkstra(G;source = 6)
