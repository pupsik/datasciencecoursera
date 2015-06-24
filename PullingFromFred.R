## Required Packages
library(quantmod)

##Fetchlist
fetchlist <- c("JPYONTD156N","NZDONTD156N","NZD1MTD156N","NZD3MTD156N","NZD6MTD156N",
               "NZD12MD156N","AUDONTD156N","AUD1WKD156N","AUD1MTD156N","AUD3MTD156N",
               "AUD6MTD156N","AUD12MD156N")

##Pull Data
for(i in length(fetchlist)){
    getSymbols(fetchlist[i], src = "FRED")
}