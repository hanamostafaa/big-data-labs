#!/usr/bin/env Rscript

con <- file("stdin", open="r")

current_id <- NULL
current_sum <- 0

while(length(line <- readLines(con, n=1, warn=FALSE)) > 0) {
  parts <- strsplit(line, "\t")[[1]]
  id <- parts[1]
  amount <- as.numeric(parts[2])

  if(!is.null(current_id) && id != current_id) {
    cat(current_id, "\t", current_sum, "\n")
    current_sum <- 0
  }

  current_id <- id
  current_sum <- current_sum + amount
}

if(!is.null(current_id)) {
  cat(current_id, "\t", current_sum, "\n")
}

close(con)