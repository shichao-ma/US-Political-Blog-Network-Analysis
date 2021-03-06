# from https://github.com/igraph/igraph/blob/master/nexus/download/polblogs.R

url <- "http://www-personal.umich.edu/~mejn/netdata/polblogs.zip"
tmp <- tempdir()
dest <- paste(sep="", tmp, "/", "polblogs.zip")

download.file(url, dest)
system(paste("cd ", tmp, "; unzip polblogs.zip"))

txt <- readLines(paste(sep="", tmp, "/polblogs.txt"))
gml <- paste(sep="", tmp, "/polblogs.gml")

library(igraph)
g <- read_graph(gml, format="gml")

g <- delete_vertex_attr(g, "id")

V(g)$name <- V(g)$label
g <- delete_vertex_attr(g, "label")

V(g)$LeftRight <- V(g)$value
g <- delete_vertex_attr(g, "value")

V(g)$Source <- V(g)$source
g <- delete_vertex_attr(g, "source")

g$name <- "US politics blog network"
g$Author <- "L. A. Adamic and N. Glance"
g$Citation <- "L. A. Adamic and N. Glance, The political blogosphere and the 2004 US Election, in Proceedings of the WWW-2005 Workshop on the Weblogging Ecosystem (2005)."
g$URL <- "http://www-personal.umich.edu/~mejn/netdata/"
g$Description <- paste(paste(collapse="\n", txt), sep="", "\n")

polblogs <- g
save(polblogs, file="polblogs.Rdata")
