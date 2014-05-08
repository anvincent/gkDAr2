## Put comments here that give an overall description of what your
## functions do

## Write a short comment describing this function

makeCacheMatrix <- function(x = matrix()) {
  # # # # initialize variables
  theMatrix <- NULL
  
  # # # # get/set methods for the vector
  ## set = sets the matrix to a new value based on the var passed
  ## get = gets the matrix that is loaded in the function
  set <- function(y) {
    x <<- y
    theMatrix <<- NULL
  }
  get <- function() x
  
  # # # # get/set methods for the inverse of the matrix
  ## setInvertedMatrix sets the internal variable theMatrix as the recently
  ##    calculated inverted matrix
  ## getInvertedMatrix gets the current set theMatrix (cached inverse matrix)
  setInvertedMatrix <- function(q) theMatrix <<- q
  getInvertedMatrix <- function() theMatrix
  
  # # # # return the available methods as a list
  list(set = set, get = get,
       setInvertedMatrix = setInvertedMatrix,
       getInvertedMatrix = getInvertedMatrix)
}


## Write a short comment describing this function

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  
  # # # # Check if inverse matrix already exists if so, return inverse matrix
  theMatrix <- x$getInvertedMatrix()  # get matrix passed into function  
  if(!is.null(theMatrix)) {           # check whether theMatrix has been cached
    message("retrieving data from cache")
    return(theMatrix)                 # matrix exists, retrieve from cache
  }
  
  # # # # if inverse matrix does not exist, calculate inverse matrix
  data <- x$get()                     # get matrix to perform the calculation
  theMatrix <- solve(data, ...)       # perform inverse matrix calculations
  x$setInvertedMatrix(theMatrix)      # cache the result so we can retrieve later
    
  theMatrix                           # return the inverted matrix
}
