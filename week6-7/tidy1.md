---
title: Tidyverse Part 1 <br> Working with Biological Data
date: July 6, 2020
---

Last time we looked at functions available in the following [Tidyverse](https://tidyverse.org) packages:

- ``readr``, ``tibble``, and ``dplyr``

We mostly used examples from the [R for Data Science](https://r4ds.had.co.nz) book.  Today's goal is to revisit these packages and apply available functions to real world, biological data sets.



### 1. Data Availability

You will need to get the data from SOC2020's official GitHub repository located at [github.com/wyoibc/SOC2020](https://github.com/wyoibc/SOC2020) by cloning it locally.

```bash

git clone https://github.com/wyoibc/SOC2020.git

cd week6-7/


```

- Note that next time you wish to sync this repository to your local computer i.e. want to catch up with all changes to this repo, simply pull it as follows:


```bash

git pull origin master


```

<br><br><br>

## 2. Importing Data into R with ``readr``

If you have used R for any amount of time, you know how to read tables (data frames) into R's memory. The standard functions you use for this purpose are ``read.table()`` for tab delimited and ``read.csv()`` for comma separated data. Hadley's ``readr`` provides similar functions that improve over the existing ``base-r`` functions in many ways.  We will look at two ways how these functions are an improvement in the following two sections:

The ``readr`` functions are:

	- ``read_tsv`` for tab delimited data

	- ``read_csv`` for comma delimited data

	- There are others such as ``read_delim`` which can read any other delimiter (provided you specify it explicitly) and ``read_fwf`` which reads fixed width columns.  We will only work with the first two functions here.


<br><br>

### 2.1 Improvements in Parsing

- Let's begin with simple examples of creating the data on fly. Package ``readr`` provides parser functions that are automatically deployed when you call any of its ``read_*`` functions. These parser functions are:

- ``parse_integer``

- ``parse_date``

- ``parse_logical``

- ``parse_character``


- Let's look at how these work:


```r

library(tidyverse)

── Attaching packages ────────────────────────────────── tidyverse 1.3.0.9000 ──
✔ ggplot2 3.3.1     ✔ purrr   0.3.4
✔ tibble  3.0.1     ✔ dplyr   1.0.0
✔ tidyr   1.1.0     ✔ stringr 1.4.0
✔ readr   1.3.1     ✔ forcats 0.5.0
── Conflicts ────────────────────────────────────────── tidyverse_conflicts() ──
✖ dplyr::filter() masks stats::filter()
✖ dplyr::lag()    masks stats::lag()

```

```r

parse_integer(c("45", "23539", "129", "555", "872"))

[1]    45 23539   129   555   872

```

- What happens when you use wrong type of data with a parser?  For example:


```r

parse_integer(c("45.1", "23539.22", "129.88", "555.59", "872.001"))

Warning: 5 parsing failures.
row col               expected actual
  1  -- no trailing characters   .1  
  2  -- no trailing characters   .22 
  3  -- no trailing characters   .88 
  4  -- no trailing characters   .59 
  5  -- no trailing characters   .001

[1] NA NA NA NA NA
attr(,"problems")
# A tibble: 5 x 4
    row   col expected               actual
  <int> <int> <chr>                  <chr> 
1     1    NA no trailing characters .1    
2     2    NA no trailing characters .22   
3     3    NA no trailing characters .88   
4     4    NA no trailing characters .59   
5     5    NA no trailing characters .001  

```

- Let's decipher the error messages we received.  At the top we get an error: ``5 parsing failure`` followed by what went wrong in each.  If you look at the first one, it says ``expected: no trailing characters`` but found ``.1``.  This is the ``parse_integer`` *checking* in the works. When you read in a tibble with either ``read_csv`` or ``read_tsv``, such parsers are applied to each column of the frame so that the data could be identified correctly and parsed.

- Here is another example:


```r

parse_character(c("pine", "spruce", "poplar", "juniper", "aspen")) 

[1] "pine"    "spruce"  "poplar"  "juniper" "aspen"  


```

- But what happens when you try to enter non-conformative data?


```r

parse_character(c("pine", "spruce", "poplar", "juniper", "22")) 

[1] "pine"    "spruce"  "poplar"  "juniper" "22"   

```


- As in the previous example, we did not receive an error message.  But there is a reason for it.  The parser is considering the input ``22`` as a character entry.  So you will not be able to use it as a number.  **One of the tidyverse principles is that each column must contain the same type of data**.  Here ``readr`` is assuming that you want to read ``22`` as a set of characters and not numbers.


- Let's try parsing decimals:


```r

parse_double(c("22", "44.1", "392.11", "549.89", "111.30")) 

[1]  22.00  44.10 392.11 549.89 111.30

```

- As you can see there were no error messages here either, even though we input 22 as integer.  But the ``parse_double`` parser intelligently turned it into a double i.e. ``22.00``.


- One of the parsing functions is ``parse_number`` which provides an additional functionality.  You may have often run into trouble when reading data tables that contains information in addition to the relevant one.  Imagine a vector that contains temperatures in degrees Celsius, but it doesn't just list the numbers. It also includes the ``C`` unit of measure.  e.g. ``4C``, ``29C``.  If you read that data into R using ``base-r`` functions, you will run into issues.  But ``parse_number`` takes care of this problem:


```r


parse_number(c("4C", "29C", "33C", "100C", "0C"))

[1]   4  29  33 100   0


```

- **Nice!**


- Let's now read a real world data set so we can see how ``readr`` and ``tibble`` improve upon the ``base-r`` data frames and the data import functions:

<br><br>

### 2.2 From ``data.frame`` To ``tibble``


- We will use the rectangular table in your downloaded folder named: ``popinfo.txt``.  This table contains geographical and ecological information on 51 populations of a boreal forest tree.


- First read it as a regular data frame with ``base-r``


```r

df <- read.table("popinfo.txt", header=TRUE)

head(df)

  pop mahalDist southernEdgeDist Zone                 Location State_Province NumInds Longitude Latitude
1 CBI 44.416413        1510509.0 Core       Cape_Breton_Island             NS       8    -61.18    46.10
2 CHL 12.626241         619981.2 Edge           Chaffey's_Lock             ON       7    -76.25    44.58
3 CLK 12.945933        1548461.0 Core                Cold_Lake             AB      14   -110.07    54.23
4 CPL  8.349012         695595.4 Core                 Chapleau             ON      14    -83.26    47.52
5 CYH 15.591883        1121559.0 Edge Cypress_Hills_Prov._Park             SK      11   -109.81    49.64
6 DCK 11.083677        1027383.0 Core            Duck_Mountain             SK      13   -101.74    51.60


```

- Then try it with the ``read_tsv`` function


```r

popinfo <- read_tsv("popinfo.txt")

Parsed with column specification:
cols(
  pop = col_character(),
  mahalDist = col_double(),
  southernEdgeDist = col_double(),
  Zone = col_character(),
  Location = col_character(),
  State_Province = col_character(),
  NumInds = col_double(),
  Longitude = col_double(),
  Latitude = col_double()
)


```


```r

popinfo

# A tibble: 51 x 9
   pop   mahalDist southernEdgeDist Zone  Location                 State_Province NumInds Longitude Latitude
   <chr>     <dbl>            <dbl> <chr> <chr>                    <chr>            <dbl>     <dbl>    <dbl>
 1 CBI       44.4          1510509. Core  Cape_Breton_Island       NS                   8     -61.2     46.1
 2 CHL       12.6           619981. Edge  Chaffey's_Lock           ON                   7     -76.2     44.6
 3 CLK       12.9          1548461. Core  Cold_Lake                AB                  14    -110.      54.2
 4 CPL        8.35          695595. Core  Chapleau                 ON                  14     -83.3     47.5
 5 CYH       15.6          1121559. Edge  Cypress_Hills_Prov._Park SK                  11    -110.      49.6
 6 DCK       11.1          1027383. Core  Duck_Mountain            SK                  13    -102.      51.6
 7 DPR        8.48          725548. Core  Deep_River               ON                  14     -77.5     46.1
 8 FIS       31.6          1801245. Core  Fischells_River          NL                   9     -58.4     48.2
 9 FNO        8.70         2413069. Core  Fort_Nelson              BC                  15    -122.      58.5
10 GAM       16.8          1058415. Core  Matagami                 QC                  15     -77.4     49.5
# … with 41 more rows


```

- The parser functions embedded in ``readr`` significantly improve upon the ``base-r`` functions.  While this example is trivial, it can really make a crucial difference for larger data sets.  


<br><br>

### 2.3 Improvements in speed while reading data

To be written...




<br><br>

### 2.4 Exercises



<br><br><br>




## 3. Transforming Data with ``dplyr``


We will look at four main functions:


### 3.1 ``dplyr::filter()``



### 3.2 ``dplyr::arrange()``


### 3.3 ``dplyr::select()``


### 3.4 ``dplyr::mutate()``



### 3.5 Exercises


1. Use ``popinfo`` tibble to find populations that are below Latitude 45 degrees

2. Find populations above 60 degrees Latitude

3. Find populations with a minimum of 5 individuals each

4. Arrange the ``popinfo`` tibble such that rows are sorted by Longitude from East to West without regard to Latitude

5. Create a new tibble that only contains population name, latitude and longitude

6. Create a logical TRUE/FALSE listing of populations where the minimum number of individuals is 7
















































<br><Br><br>
