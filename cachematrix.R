## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function:
#### This function creates a special object "matrix" that can cache its inverse
makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL
  set <- function(y) {
    x <<- y
    inv <<- NULL
  }
  get <- function() x
  setinv <- function(inverse) inv <<- inverse
  getinv <- function() inv
  list(set = set, get = get,
       setinv = setinv,
       getinv = getinv)
}


## Write a short comment describing this function
#### This program checks if the inverse object is empty, and if it is, it calls
#the command to calculate the inverse. If not, it pulls the inverse from cache.
cacheSolve <- function(x, ...) {
  inv <- x$getinv()
  if(!is.null(inv)) {
    message("getting cached data")
    return(inv)
  }
  data <- x$get()
  inv <- solve(data, ...)
  x$setinv(inv)
  inv   # this is the return matrix
  ## Return a matrix that is the inverse of 'x'
}