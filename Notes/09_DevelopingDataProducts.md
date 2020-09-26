---
title: "Developing Data Products"
author: "Nathan W. Van Bibber"
date: "4/14/2020"
output: 
  html_document: 
    keep_md: yes
---



# Week 1

## Shiny

Shiny is a product by RStudio, described by RStudio as:  

> “A web application framework for R... Turn your analyses into interactive web applications. No HTML, CSS, or JavaScript knowledge required.” 

A little HTML would be useful for understanding some of the concepts.  

It is important to dinstiguish between a Shiny application (app) and a Shiny server. A Shiny server is required to host a shiny app for the world. Otherwise, only those who have have shiny installed and have access to your code could run your web page.  

Creating a shiny server requires understanding of linux server administration, but we can run our apps locally and use RStudio’s service, shinyapps.io (their servers), for hosting shiny apps on a platform. 

* Shiny is a web application framework for R made by R Studio.
* Allows you to greate a graphical interface so users can interact with your visualizations, models, and algorithms without neeking to know R themselves
* allows you to quickly create simple, yet powerful, web-based interactive data products in R.

### Mild Prerequisites

* Knowledge of HTML, CSS, and Javascript is very helpful
    - HTML gives structure and sectioning as well as markup instructions
    - CSS gives the style
    - Javascript for interactivity
* Shiny uses **Bootstrap** style (creation of Twitter -- no relation to stastical term) to allow app to render well across multiple platforms
* Tutorials available:
    - HTML and CSS from Khan Academy
    - Free Code Camp
    - Mozilla Developer Network Tutorials
    - Official Shiny tutotial at R Studio

First steps: Install and load `shiny` package

```r
# install.packages("shiny")
library(shiny)
```

A shiny project is a directory containing at least 2 files:

1. **ui.R** -- user interface, controls how your app looks
2. **server.R** -- controls what your app does

Start each Shiny app with the following template

```r
library(shiny)
ui <- fluidPage("Hello World")

server <- function(input, output) {}

shinyApp(ui, server) 
```

### Design the app with ui

Add elements as arguments to `fluidPage()`

* `*Input()` - create reactive inputs (eg. slider bars)
* `*Output()` - create reactive results (eg.  plots)

### Use the server function to assemble inputs and outputs

> Reactivity automatically occurs whenever you use an input value to render an output object

**3 rules for the server function**

1. *Save* output objects to `output$...`
2. *Build* objects to display with `render*()`
    * plot, table, image, text, etc.
3. *Access* input values with `input$`



```r
library(shiny)
ui <- fluidPage(
    sliderInput(inputId = "num", 
        label = "Pick a value for N", 
        value = 50, min = 20, max = 100),
    plotOutput(outputId = "hist")
)

server <- function(input, output) {
    output$hist <- renderPlot({
        title <- "N random normal values"
        hist(rnorm(input$num), main = title)
    })
}

shinyApp(ui, server)
```

### Reactivity

#### Reactive values

* Reactive values act as the data streams that folw through your app.
* The **input** list is a list of reactive values. (show the current state of the inputs)
* **Note:** you can only call a reactive value from a function that is designed to work with one (i.e. a reactive function)

#### Reactive functions

1. Use a code chunk to build (and rebuild) an object
    * What code will the function use?
2. Object will respond to changes in a set of reactive values
    * Which reactive values will the object respond to?
    
#### Reactivity as a 2-step process

1. Reactive values (eg. `input$num`) notify the functions that use them when they have changed (aka invalidating) 
2. Objects created by reactive functions respond as appropriate (eg. re-run code). 
    
#### Reactive toolkit (7 indispendible functions)

1. `render*()`
    * Builds reactive output *object to display* in UI
    * Takes one argument - {a block of code} surrounded by curley braces
    * Always save results to `output$`
2. `reactive()`
    * builds a reactive *object to use* (reactive expression)
        - knows whether it is invalid or valid
        - result is saved (cached) in memory
    * result available to use later on in other code
        - technically a function so must call with parens (eg. `data()`)
    * useful for modularizing your apps
3. `isolate()`
    * makes a non-reactive object
        - prevent reactions 
        - object will **not** respond to *any reactive value* in the code
    * use to treat reactive values like normal R values
4. `observeEvent()`
    * Triggers code to run on server
5. `eventReactive()`
    * a reactive expression that only responds to specific values





## Shiny Gadgets

## GoogleVis

## Plotly



***

# Week 2

## R Markdown



## Leaflet


***

# Week 3

## R Packages

### What is an R Package?

* A mechanism for extending the basic functionality of R
* Collection of R functions, or other (data) objects
    - wrapped together with other elements (eg. documentation)
* Organized in a systemic way to provide consistency

### Where are R Packages?

* CRAN and Bioconductor (Bioinformatics and Genomics tools)
    - installed with `install.packages()`
* GitHub
    - installed with `devtools::install_github()`
* Bitbucket, Gitorious, and elsewhere
* You do not have to put a package on a central repository, but doing so makes it easier for others to install your package.

### What's the point?

* Forces you to write documentation to explain how your function should be used
    - document arguments and return values
* Allows for well defined *Application Programming Interface (API)* to tell users what and how to use the functions
    - much of the implementation details can be hidden from the user so that updates can be made without interfering with use cases
    - API allows you to abstract implementation from the user
* Easier to maintain
* Standards for reliability and robustness
    - load properly without problems

### Package Development Process

1. Have some R code in a script you want to make available for others
2. Incorporate R script file into R Package structure
3. Write documentation for user functions
4. Include other material (eacmples, demos, datasets, tutorials)
5. Package it up!
6. Submit to CRAN/Bioconductor or push to GitHub (or other code sharing website)
7. Update your package
    - other people will find problems in you code and point them out or fix them
    - Incorporate these changes and release a new version 
    
### R Package Essentials

* A ***directroy*** with the same name as the name of the R package
    - `DESCRIPTION` file -- info about the package
    - `R/` sub-directory -- for R code
    - `man/` subdirectory -- for documentation
    - `NAMESPACE` file (optional but highly recommended)
* Start a package as a project in a new directory
    - generate skeleton by clicking on _Project_ $\rightarrow$ _New Project_ $\rightarrow$ _New Directory_ $\rightarrow$ _R Package_ $\rightarrow$ fill in package names and details
    - automatically generates the structure/skeleton of a new R package

* another option is to use `utils::package.skeleton()` function to create a "skeleton" R package
	- automatically creates directory structure (`R/`, `man/`), DESCRIPTION file, NAMESPACE file, documentation files
	- if there are any functions in the current workspace, their code will be written as R code files in the `R/` directory
	- documentation stubs are created in `man/` directory
	- the rest of the content can then be modified and added


See [Writing R Extensions](https://cran.r-project.org/doc/manuals/r-release/R-exts.html) for full requirements.  
Also the book [R Packages](http://r-pkgs.had.co.nz/) by Hadley Wickham is a good resource.  

#### **DESCRIPTION** file

* **Package:** name of package (e.g. `library(name)`) used to load the package
* **Title:** full name of package (slightly longer description beyond the name)
* **description:** Even longer description of package (one or two sentences)
* **Version:** version number (usually `M.m-p` format, where M = major number, m = minor number and p = patch level)
* **Author:** Name of the author(s) (people who wrote the original code)
* **Maintainer:** name & email of person who's responsible for fixing problems
* **License:** license for the source code (describes the terms that the source code is released under)
    - usually open sources licenses are used (eg. GNU, BSD, MIT)

Optional fields (but commonly used)

* **Depends:** R packages that your package depends on
* **Suggests:** optional R packages that users may want to have installed (but are not essential to running R code)
* **Date:** release date in YYYY-MM-DD format
* **URL:** package home page (link to repository)
* **Other** fields can be added but are ignored by R

#### **R/** sub-directory

* For R code (R code should *only* be in this folder and nowhere else in package)
* Can be organized in any way, and can have any number of files
    - typically want to organize files into logical groups (similar functions together in a single file)
    
#### **NAMESPACE** file

Indicates the API for your function and lists all dependencies.
Need tp indicate two things:

1. **export** functions -- available to the user
    - can be called by the user and considered the public API 
    - *non-exported* functions cannot be called directly by the user. This allows you to hide implementation datails from users and have a cleaner package interface
2. **import** functions from other packages
    - allows your package to use other packages without making other packages cisible to the user
    - importing a function loads the package but does not attach it to the search list

Key directives for NAMESPACE file (look like R functions but are not exactly)

* `export("<function>")` -- export a function
* `import("<package>")` -- import a package
* `importFrom("<package>", "<function>")` -- import a specific function from a package

Other directives also important

* `exportClasses("<class>")` -- if your functions create new S4 classes
* `exportMethods("<generic>")` -- methods that can operate on the new class objects

#### **man/** sub-directory

For documentation files (.Rd) 

* Allows the user to understand how your function is supposed to be used
* Written in a special markup language
* A Documentation file is **required** for every *exported* function
    - a good reason to limit the number of exported functions  
* You can also document other things (datasets, concepts, package overview)

Components:

* `\name{}` = name of function
* `\alias{}` = anything listed as alias will bring up the help file 
		+ multiple aliases possible
* `\title{}` = full title of the function
* `\description{}` = full description of the purpose of function
* `\usage{}` = format/syntax of function
* `\arguments{}` = explanation of the arguments in the syntax of function
* `\details{}` = notes/details about limitation/features of the function
* `\value{}` = specifies what object is returned
* `\reference{}` = references for the function (paper/book from which the method is created)


```r
\name{line}
\alias{line}
\alias{residuals.tukeyline} # both`?line` and `?residuals.tukeyline` will work
\title{Robust Line Fitting}
\description{
  Fit a line robustly as recommended in \emph{Exploratory Data Analysis}.
}
\usage{
line(x, y)
}
\arguments{
  \item{x, y}{the arguments can be any way of specifying x-y pairs.  See
    \code{\link{xy.coords}}.}
}
\details{
  Cases with missing values are omitted.

  Long vectors are not supported.
}
\value{
  An object of class \code{"tukeyline"}.

  Methods are available for the generic functions \code{coef},
  \code{residuals}, \code{fitted}, and \code{print}.
}
\references{
  Tukey, J. W. (1977).
  \emph{Exploratory Data Analysis},
  Reading Massachusetts: Addison-Wesley.
}
```

### Documenting package functions with *Roxygen2*


***Roxygen2*** package will be leveraged to extract and format the documentation from R script automatically

1. write the code in a `.R` script
2. add documentation *directly* to the script

`Roxygen2` will extract the documentation from the code file and make the `man/` documentation pages and formats them appropiately

* keeps code and documentation together in one file
    - helps because you don't have to switch back and forth between 2 files
    - better chance the documentation will stay up to date
       
*Roxygen2* syntax

* `#'` = denotes the beginning of documentation (R will automatically add `#'` on the subsequent lines as you type ENTER to complete sections)
* **title** -- 1^st^ line (relatively concise, a few words)
* **description/summary** -- 3^rd^ line (1-2 sentences) 
* `@param` `x` *definition* = format of the documentation for the parameters/arguments
    - `x` = parameter name 
    - *definiton* = explanation of the what x represents
* `@author` = author of the function
* `@details` = detailed description of the function and its purpose
* `@seealso` = links to relevant functions used in creating the current function that may be of interest to the user
* `@import package function` = imports specific function from specified package
* `@export` = denotes that this function is exported for public use
* `@return` = specifies what is returned by the method  


#### Example: `topten` function

```r
#' Building a Model with Top Ten Features
#'
#' This function develops a prediction algorithm based on the top 10 features
#' in 'x' that are most predictive of 'y'.
#'
#' @param x a n x p matrix of n observations and p predictors
#' @param y a vector of length n representing the response
#' @return a vector of coefficients from the final fitted model with top 10 predictors
#' @author Roger Peng
#' @details
#' This function runs a univariate regression of y on each predictor in x and
#' calculates a p-value indicating the significance of the association. The
#' final set of 10 predictors is the taken from the 10 smallest p-values.
#' @seealso \code{lm}
#' @export
#' @importFrom stats lm

topten <- function(x, y) {
        p <- ncol(x)
        if(p < 10)
                stop("there are less than 10 predictors")
        pvalues <- numeric(p)
        for(i in seq_len(p)) {
                fit <- lm(y ~ x[, i])
                summ <- summary(fit)
                pvalues[i] <- summ$coefficients[2, 4]
        }
        ord <- order(pvalues)
        x10 <- x[, ord]
        fit <- lm(y ~ x10)
        coef(fit)
}

#' Prediction with Top Ten Features
#'
#' This function takes a set coefficients produced by the \code{topten}
#' function and makes a prediction for each of the values provided in the
#' input 'X' matrix.
#'
#' @param X a n x 10 matrix containing n new observations
#' @param b a vector of coefficients obtained from the \code{topten} function
#' @return a numeric vector containing the predicted values
#' @export

predict10 <- function(X, b) {
        X <- cbind(1, X)
        drop(X %*% b)
}
```

### Building and Checking a package

Once you have your package skeleton with R code and documentation, you can build your package and reload it into R:

1. Go to the *Build* tab $\rightarrow$ *Build and Reload* button 
    - Documentation files not yet created by *Roxygen2* package
    - Note: the package documentation file is not required. You can delete it rather than fill it out.
2. *More* $\rightarrow$ *Configure Build Tools* $\rightarrow$ check box *Generate documentation with Roxygen* and make sure the following boxes are checked (bold you will probably have to check yourself)
    - Rd files
    - **NAMESPACE file**
    - R CMD check
    - Souce and Binary package Builds
    - **Build and Reload**
3. *Build and Reload* the package again
    - check you function documentation files are now completed.
    - try looking at your function code with `functionName` and documentation with `?functionName`!
4. Go to the *Build* tab $\rightarrow$ *Check*
    - will build the package and run `R CMD Check` on it
5. If all the tests pass you can upload the package to CRAN

More details on Building and Checking a package

* **R CMD (Command) Build** is a command-line program that creates a package archive file (format = `.tar.gz`)
* **R CMD Check** is a command-line program that runs a battery of tests on the package to ensure structure is consistent, all components are present, and export and import are appropriately specified
* R CMD Build and R CMD check can be run from the command-line using terminal/command-shell applications or they can be run from R using the `system()` function
	- `system("R CMD build newpackage")`
	- `system("R CMD check newpackage")`
* the package must pass ***all*** tests to be put on CRAN
	- documentation exists for all exported function
	- code can be loaded without any major coding problems/errors
	- contains license
	- ensure examples in documentation can be executed
	- check documentation of arguments matches argument in the code

***

### Checklist for Creating Package
- create a new directory with `R/` and `man/` sub-directories (or just use `package.skeleton()`)
- write a DESCRIPTION file
- copy R code into the `R/` sub-directory
- write documentation files in `man/` sub-directory
- write a NAMESPACE file with exports/imports
- build and check


***
***

# Week 4

## Swirl Courses
