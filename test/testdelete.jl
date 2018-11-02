using MyGraph

G = buildconnectedgraph(collect(1:6), (a,b) -> first(abs.(rand(Int8, 1))))
