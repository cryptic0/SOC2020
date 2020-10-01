---
title: Making Your First R Package
author: Vikram Chhatre
date: June 16, 2020
---



## Making Your First R Package

During week 4, we attempted to wrap our R functions into packagess.  Following topics were covered:


### 1.1 What is a R function?

Here are some simple examples of R functions:

- Take the square root of the input number:


```r

sr <- function(x){

	sqrt(x)

}

```

```r

sr(75)

[1] 8.660254

```



- Multiply two input numbers:


```r

mply <- function(x, y){
	
	x*y

}

```


```r

mply(709, 552)

[1] 391368


```


Real world application functions can be far more complex. Let's take it a notch up.


### 1.2 Function to read a file and print its head


- Imagine you wish to write a function that can read an input file.  The filename is provided as an argument to the function by the user who executes the function.  We then print the first few lines of this file to the screen.


```r

rf1 <- function(infile){

	store <- read.table(infile, header=TRUE, sep='\t')

	print(paste0("The input file is: ", infile))

	print(paste0("Here are the first few lines of this file:"))

	head(store)

}


```


- Of course, now we need a file that can be read by this simple function.  It's easy to create files with data on the fly in R enviroment.  Let's generate a sample of 20 random numbers and repeat that process 5 times:


```r

myfile <- replicate(5, sample(20))

myfile

      [,1] [,2] [,3] [,4] [,5]
 [1,]   12   10    5    3    3
 [2,]    1    2   11   16   16
 [3,]   13   16    7   18    8
 [4,]   19   12    8   19    2
 [5,]   15    9   10   10   20
 [6,]   16   18    9    7   14
 [7,]    7   14   18    6    7
 [8,]   10   17    6   12   13
 [9,]    5    4    4    2   11
[10,]    9    6    2   20    4
[11,]    6    3   15   15   17
[12,]   14    5    3    9    9
[13,]    4   20   17    4   10
[14,]   17   11   13   17    5
[15,]    3   15    1   13    6
[16,]   20    7   16   14   18
[17,]   18    1   19    1    1
[18,]   11   13   12    5   19
[19,]    8    8   20    8   15
[20,]    2   19   14   11   12

``` 

- Note that we do not have column names here.  Let's add those:


```r

colnames(myfile) <- c("rep1", "rep2", "rep3", "rep4", "rep5")

myfile

      rep1 rep2 rep3 rep4 rep5
 [1,]   12   10    5    3    3
 [2,]    1    2   11   16   16
 [3,]   13   16    7   18    8
 [4,]   19   12    8   19    2
 [5,]   15    9   10   10   20
 [6,]   16   18    9    7   14
 [7,]    7   14   18    6    7
 [8,]   10   17    6   12   13
 [9,]    5    4    4    2   11
[10,]    9    6    2   20    4
[11,]    6    3   15   15   17
[12,]   14    5    3    9    9
[13,]    4   20   17    4   10
[14,]   17   11   13   17    5
[15,]    3   15    1   13    6
[16,]   20    7   16   14   18
[17,]   18    1   19    1    1
[18,]   11   13   12    5   19
[19,]    8    8   20    8   15
[20,]    2   19   14   11   12


```

- We can use this file as input to the function, but it needs to be written to the disk first:

```r

write.table(myfile, "myfile.txt", quote=F, sep='\t', col.names=T, row.names=F)

```

```r

rf1("myfile.txt")

[1] "The input file is: myfile.txt"
[1] "Here are the first few lines of this file:"
  rep1 rep2 rep3 rep4 rep5
1   12   10    5    3    3
2    1    2   11   16   16
3   13   16    7   18    8
4   19   12    8   19    2
5   15    9   10   10   20
6   16   18    9    7   14

```


### 1.3 Writing a R package using the function 

- Before we begin, you will need to install and load the following packages:


```r

install.packages(c("devtools", "roxygen2"))

load(c(devtools, roxygen2))

sessionInfo()

```

The session info command output will allow you to verify whether the packages were correctly loaded.  


- Next, navigate to a folder similar to the following one on your computer:

```r

setwd("/Users/yourname/Github/R_Packages")


```

- Ask devtools to create a new package folder:


```r

devtools::create("mypkg")

setwd("mypkg")

list.files()

[1] "DESCRIPTION"   "NAMESPACE"     "R"


```

Save your function inside the ``R`` folder as ``rfile.R``


```bash

vim R/rfile.R

```


```r

rf1 <- function(infile){

	store <- read.table(infile, header=TRUE, sep='\t')

	print(paste0("The input file is: ", infile))

	print(paste0("Here are the first few lines of this file:"))

	head(store)

}

```


- Insert some documentation for your code and export the function to the namespace as follows:


```r

#' Function: rf1 to read a tab delimited file and display it's head

#' @export

rf1 <- function(infile){

	store <- read.table(infile, header=TRUE, sep='\t')

	print(paste0("The input file is: ", infile))

	print(paste0("Here are the first few lines of this file:"))

	head(store)

}

```

- Save and close the file

```bash

:wq


```


- Now run the following commands to respectively compile documentation, install package and load it in R's memory:


```r

devtools::document()

devtools::install()

library(rfile)


```

- At this point, your R package is created, installed and loaded for use.  Try running the ``rf1()`` function on the same file locally:


```r

rf1("myfile.txt")

```

- If this command succeeded, you are ready to move onto the next step.


### 1.4 Sharing your new package on GitHub


This process is similar to the Github repo protocol we followed a couple of weeks ago.  First log onto your github account and create a new repo called ``rfile``.


```bash

cd ~/Github/R_Packages/mypkg

git status

git add .

git commit -m "Initial commit for R package"

git config user.name "your_github_id"

git config user.email "your_github_associated_email_id"

git config --list

git remote add origin https://github.com/YOUR_GITHUB_ID/rfile.git

git remote -v

git push -u origin master


```


### 1.5 How others can install your package

It's straightforward:

```r

library(devtools)

devtools::install_github("YOUR_GITHUB_ID/rfile")

```

That's it.  

You have now written a function, created a package from it and uploaded it to GitHub for sharing with others.  Your package is only accessible to others if it is in the public domain.  If it's private, you can still add collaborators who will have access to it.


### 2. Try it again

You could try writing a more complex function on your own and then create a package using that function.  Any questions, shoot us a message on Slack.


