// Adjacency list representation
type Graph is ([{int}])

function depthFirstSearch(int v, Graph graph, {int} visited) -> {int}:
    visited = visited + {v}
    // Traverse edges not yet visited
    for w in graph[v]:
        if !(w in visited):
            visited = depthFirstSearch(w,graph,visited)
    // Done
    return visited
