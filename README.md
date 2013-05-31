


rbison
======

Wrapper to the USGS Bison API. 

### Info

See [here](http://bison.usgs.ornl.gov/services.html) for API docs for the BISON API.


### Quick start

#### Install rbison


```r
# install.packages('devtools') library(devtools) install_github('rbison',
# 'ropensci')
library(rbison)
```


Notice that the function `bisonmap` automagically selects the map extent to plot for you, 
being one of the contiguous lower 48 states, or the lower 48 plus AK and HI, or a global map

#### If some or all points outside the US, a global map is drawn, and throws a warning. . You may want to make sure the occurrence lat/long coordinates are correct.
##### get data

```r
out <- bison(species = "Phocoenoides dalli dalli", count = 10)
```


##### inspect summary

```r
bison_data(out)
```

```
  total specimen
1     7        7
```


##### map occurrences

```r
bisonmap(out)
```

```
Some of your points are outside the US. Make sure the data is correct
```

![plot of chunk unnamed-chunk-5](inst/assets/img/unnamed-chunk-5.png) 



####  All points within the US (including AK and HI)
##### get data

```r
out <- bison(species = "Bison bison", count = 600)
```


##### inspect summary

```r
bison_data(out)
```

```
  total observation fossil specimen unknown
1   761          30      4      709      18
```


##### map occurrences

```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-8](inst/assets/img/unnamed-chunk-8.png) 


####  All points within the contiguous 48 states
##### get data

```r
out <- bison(species = "Aquila chrysaetos", count = 600)
```


##### inspect summary

```r
bison_data(out)
```

```
  total observation fossil specimen literature unknown centroid
1 41731       39331     30     1618        118     634      904
```


##### map occurrences

```r
bisonmap(out)
```

![plot of chunk unnamed-chunk-11](inst/assets/img/unnamed-chunk-11.png) 



####  With any data returned from a `bison` call, you can choose to plot county or state level data
##### Counties - using last data call for Aquila 

```r
bisonmap(out, tomap = "county")
```

![plot of chunk unnamed-chunk-12](inst/assets/img/unnamed-chunk-12.png) 


##### States - using last data call for Aquila 

```r
bisonmap(out, tomap = "state")
```

![plot of chunk unnamed-chunk-13](inst/assets/img/unnamed-chunk-13.png) 

