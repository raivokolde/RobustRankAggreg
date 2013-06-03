\name{aggregateRanks}
\alias{RobustRankAggreg}
\alias{aggregateRanks}
\title{Aggregate ranked lists}
\usage{
  aggregateRanks(glist,
    rmat = rankMatrix(glist, N, full = full), N = NA,
    method = "RRA", full = FALSE, exact = F,
    topCutoff = NA)
}
\arguments{
  \item{glist}{list of element vectors, the order of the
  vectors is used as the ranking.}

  \item{rmat}{the rankings in matrix format. The glist is
  by default converted to this format.}

  \item{N}{the number of ranked elements, important when
  using only top-k ranks, by default it is calculated as
  the number of unique elements in the input.}

  \item{method}{rank aggregation method, by defaylt
  \code{'RRA'}, other options are \code{'min'},
  \code{'geom.mean'}, \code{'mean'}, \code{'median'} and
  \code{'stuart'}}

  \item{full}{indicates if the full rankings are given,
  used if the the sets of ranked elements do not match
  perfectly}

  \item{exact}{indicator showing if exact p-value will be
  calculated based on rho score (Default: if number of
  lists smaller than 10, exact is used)}

  \item{topCutoff}{a vector of cutoff values used to limit
  the number of elements in the input lists elements do not
  match perfectly}
}
\value{
  Returns a two column dataframe with the element names and
  associated scores or p-values.
}
\description{
  Method implementing various gene list aggregation
  methods, most notably Robust Rank Aggregation.
}
\details{
  All the methods implemented in this function make an
  assumtion that the number of ranked items is known. This
  assumption is satisfied for example in the case of gene
  lists (number of all genes known to certain extent), but
  not when aggregating results from google searches (there
  are too many web pages). This parameter N can be set
  manually and has strong influence on the end result. The
  p-values from RRA algorithm can be trusted only if N is
  close to the real value.

  The rankings can be either full or partial. Tests with
  the RRA algorithm show that one does not lose too much
  information if only top-k rankings are used. The missing
  values are assumed to be equal to maximal value and that
  way taken into account appropriately.

  The function can handle also the case when elements of
  the different rankings do not overlap perfectly. For
  example if we combine resutls from different microarray
  platforms with varying coverage. In this case these
  structurally missing values are substituted with NA-s and
  handled differently than omitted parts of the rankings.
  The function accepts as an input either list of rankings
  or rank matrix based on them. It converts the list to
  rank matrix automatically using the function
  \code{\link{rankMatrix}}. For most cases the ranking list
  is more convenient. Only in complicated cases, for
  example with top-k lists and structural missing values
  one would like to construct the rank matrix manually.

  When the number of top elements included into input is
  specified in advance, for example some lists are limited
  to 100 elements, and the lengths of these lists differ
  significantly, we can use more sensitive and accurate
  algorithm for the score calculation. Then one has to
  specify in the input also the parameter topCutoff, which
  is a vector defining an cutoff value for each input list.
  For example if we have three lists of 1000 elements but
  first is limited to 100, second 200 and third to 900
  elements, then the topCutoff parameter should be c(0.1,
  0.2, 0.9).
}
\examples{
# Make sample input data
glist <- list(sample(letters, 4), sample(letters, 10), sample(letters, 12))

# Aggregate the inputs
aggregateRanks(glist = glist, N = length(letters))
aggregateRanks(glist = glist, N = length(letters), method = "stuart")

# Since we know the cutoffs for the lists in advance (4, 10, 12) we can use
# the more accurate algorithm with parameter topCutoff

# Use the rank matrix instead of the gene lists as the input
r = rankMatrix(glist)

aggregateRanks(rmat = r)

# Example, when the input lists represent full rankings but the domains do not match
glist <- list(sample(letters[4:24]), sample(letters[2:22]), sample(letters[1:20]))
r = rankMatrix(glist, full = TRUE)
head(r)

aggregateRanks(rmat = r, method = "RRA")

# Dataset representing significantly changed genes after knockouts
# of cell cycle specific trancription factors
data(cellCycleKO)
r = rankMatrix(cellCycleKO$gl, N = cellCycleKO$N)
ar = aggregateRanks(rmat = r)
head(ar)
}
\author{
  Raivo Kolde <rkolde@gmail.com>
}
\references{
  Kolde et al "Robust Rank Aggregation for gene list
  integration and meta-analysis" (in preparation)
}

