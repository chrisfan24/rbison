#' Get statistics about BISON downloads.
#' 
#' @import httr jsonlite
#' @export
#' 
#' @param what (character) One of stats (default), search, downnload, or wms. See Details.
#' @param callopts Further args passed on to httr::GET for HTTP debugging/inspecting.
#' @return A list of data frame's with names of the list the different data sources
#' 
#' @details
#' For the 'what' parameter:
#' \itemize{
#'  \item stats - Retrieve all data provider accumulated statistics.
#'  \item search - Retrieve data provider statistics for BISON searches.
#'  \item download - Retrieve data provider statistics for data downloads from BISON.
#'  \item wms - Retrieve data provider statistics for BISON OGC WMS tile requests.
#' }
#' 
#' @examples \dontrun{
#' out <- bison_stats()
#' out <- bison_stats(what='search')
#' out <- bison_stats(what='download')
#' out <- bison_stats(what='wms')
#' out$Arctos
#' out$Harvard_University_Herbaria
#' out$ZooKeys
#' }

bison_stats <- function(what='stats', callopts=list())
{
  what <- match.arg(what, c('stats','search','download','wms'))
  pick <- switch(what, stats='all', search='search', download='download', wms='wms')
  url <- switch(what, 
                stats = 'http://bison.usgs.ornl.gov/api/statistics/all',
                search = 'http://bison.usgs.ornl.gov/api/statistics/search',
                download = 'http://bison.usgs.ornl.gov/api/statistics/download',
                wms = 'http://bison.usgs.ornl.gov/api/statistics/wms')
  
  out <- GET(url, callopts)
  stop_for_status(out)
  tt <- content(out, as = "text")
  res <- fromJSON(tt, simplifyVector = FALSE)
  output <- lapply(res$data, function(x){
    df <- data.frame(do.call(rbind, x[[pick]]), stringsAsFactors = FALSE)
    list(name=x$name, resources=do.call(c, x$resources), data=df)
  })
  names(output) <- gsub("\\s", "_", vapply(res$data, "[[", "", "name"))
  return( output )
}