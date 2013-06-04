\name{rankMatrix}
\alias{rankMatrix}
\title{Create rank matrix}
\usage{
  rankMatrix(glist, N = NA, full = FALSE)
}
\arguments{
  \item{glist}{list of preference lists}

  \item{N}{number of all rankable elements}

  \item{full}{logical showing if the given rankings are
  complete}
}
\value{
  A matrix, with as many columns as input rankings and rows
  as unique elements in all the rankings combined.
}
\description{
  Convert a set of ranked lists into a rank matrix
}
\details{
  The lists are converted to a format that is used by
  aggregateRanks. If partial rankings are given to the
  function, all the missing values are subtituted by the
  maximum rank N, which can be specified manually. This
  parameter has a very strong influence on the performance
  of RRA algorithm, therfore it should be reasonably
  accurate. If the N is different for the gene lists, it
  can be also given as a vector.

  Parameter full is used, when full rankings are given, but
  the sets of ranked elements do not match perfectly. Then
  the structurally missing values are substituted with
  NA-s.
}
\examples{
# Make sample input data
glist <- list(sample(letters, 4), sample(letters, 10), sample(letters, 12))

r = rankMatrix(glist)
r = rankMatrix(glist, full = TRUE)

# Use real data
data(cellCycleKO)
r = rankMatrix(cellCycleKO$gl, N = cellCycleKO$N)
}
\author{
  Raivo Kolde \email{rkolde@gmail.com}
}

