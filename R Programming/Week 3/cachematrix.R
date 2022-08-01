## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

## The first fucntion is basic enough. set() and get() are the setter/getter for the matrix value
## while setinverse() and getinverse() are the setter/getter for the inverse value. These are
## essentially taken from the problem explanation with 'm' replaced with 'inv' and 'mean' with 'inverse'.
## The final piece of code returns these values as a named list so that the functions can be called
## using the $ operator.

makeCacheMatrix <- function(x = matrix()) {
  inv <- NULL                                # Initializes the inverse variable
  
  set <- function(y) {                       # This function will set the data to be whatever is passed
    x <<- y                                  # as y in x$set(y), replacing old date. It then removes
    inv <<- NULL                             # any existing cached inverse
  }
  
  get <- function() x                        # Simply returns the matrix
  
  setinverse <- function(inverse) inv <<- inverse     # Sets the inverse to be the value passed under the only parameter
  
  getinverse <- function() inv                        # Simply returns the inverse
  
  list(set = set, get = get, setinverse = setinverse, getinverse = getinverse)
                # This bit returns the 4 defined functions as a list which can be called by the second function
}

## Write a short comment describing this function

cacheSolve <- function(x, ...) {
  
  inv <- x$getinverse()                      # Firstly, this checks to see if an inverse exists...
  if(!is.null(inv)) {                        # ... so that this line can return the cached value if it does
    message("Retreiving cached value")
    return(inv)
  }
  
  data <- x$get()                            # Barring that, first retrieve the matrix
  inv <- solve(data, ...)                    # Now, call solve() to find its inverse, (assumed invertable)
  x$setinverse(inv)                          # Set the inverse value to be the caluclated inverse
  inv                                        # And finally, return the inverse as calculated
}

## Here I shall include the output of the function given an invertable matrix:

## mat1 <- matrix(c(1,0,5,2,1,6,3,5,0), nrow=3, ncol=3)
## > cachemat1 <- makeCacheMatrix(mat1)
## > cacheSolve(cachemat1)
# [,1] [,2] [,3]
# [1,]   -6  3.6  1.4
# [2,]    5 -3.0 -1.0
# [3,]   -1  0.8  0.2
## > cacheSolve(cachemat1)
# Retreiving cached value
# [,1] [,2] [,3]
# [1,]   -6  3.6  1.4
# [2,]    5 -3.0 -1.0
# [3,]   -1  0.8  0.2
