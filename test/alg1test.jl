using MyGraph

G = buildconnectedgraph(collect(1:6), (a,b) -> first(abs.(rand(Int8, 1))))

T,t = alg1(G; source = 1, start = 1)
H,h = alg1(G; source = 3, start = 3)
