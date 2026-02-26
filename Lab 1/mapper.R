#!/usr/bin/env Rscript

con <- file("stdin", open="r")

while(length(line <- readLines(con, n=1, warn=FALSE)) > 0) {
  parts <- strsplit(line, ",")[[1]]
  if(length(parts) == 2) {
    cat(parts[1], "\t", parts[2], "\n", sep="")
  }
}
close(con)