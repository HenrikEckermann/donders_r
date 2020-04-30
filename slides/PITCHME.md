




@snap[mid]
#### DondeRs



@snap[mid dtext text-07]
Henrik Eckermann
@snapend




---

@snap[mid]
#### Session 1



@snap[mid dtext text-07]
Before you learn the language
@snapend

Note:

1. About me
2. Learning Goals
3. What do you want to learn?
4. Why learning R
5. How to use R as a beginner
6. Types of R files
7. Ensuring reproducibility
8. How to learn the language


+++ 

#### About me 


Note:  
1. Self learner and no computer scientist and what that means for you 
2. My approach: Learn as you need and do but make sure to always do...



+++

@snap[west span-45 text-center]
#### Learning Goals
@snapend

@snap[east span-45 text-center text-07]
- basics of R programming
- how to approach R
- first steps in analysis
@snapend



Note:  
- what to expect and what not 


+++

#### What do you want to learn?

Note:  

What must be your accomplishment so you think positive about your time investment in this course?


+++

@snap[west span-45 text-center]
#### Why R
@snapend

@snap[east span-45 text-center text-07]
- innovations
- level of understanding
- collaboration 
- reproducibility
- free and open source
@snapend

Note:  
1. newest developments are available in programming languages such as R/Python
2. Working with scripts forces you to have a deeper understanding of what you are doing, and facilitates your learning and comprehension of the methods you use.
3. collaboration and large community: R and Python and several other languages are common among scientists
4. reproducibility: R code can be published with your article and ease reproducibility, 
5. versatile tool that goes beyond data analysis (e.g. homepage, books, file manipulation, automation of otherwise cumbersome work)
6. R is free and open source 

+++

@snap[west span-45 text-center]
#### How to use R as beginner 
@snapend



@snap[east span-45 text-center text-07]
- RStudio
- working directory
- typical data structure
- Do it neat from the very beginning: Tidyverse
@snapend

 

Note:  


+++

#### Types of R files



+++

#### Ensuring reproducibility

Note:  
- create an R project 

+++

#### How to learn the language 

Note:  
1. Attitude 
2. Where to seek help: stackoverflow, github, show to google for help, help functions



+++


#### Homework session 1


Note: 

1. Read chapter 1 of the [Tidyverse coding style guide](https://style.tidyverse.org/files.html)
 - dont be afraid of new terminology. Reading through will still help you to get familiar with R over time.

2. Create an rProject for a project that you are currently working on and organize the files as I demonstrated. Organize the project in such a way that another researcher could get a grasp of what is going on by just looking at it.

+++













<!-- Session 2 -->
---

@snap[mid]
#### Session 2
@snapend



@snap[mid dtext text-07]
Introduction to R
@snapend

Note:

1. **Objects and datatypes R**
   - How to use R
   - Atomic vectors
   - Lists
   - Dataframes
   - NULL
   - NA
2. **Subsetting of these dataypes**

+++

![vectors](assets/img/data-structures-overview.png)

Note:  
There are two types of vectors:

Atomic vectors, of which there are six types: logical, integer, double, character, complex, and raw. Integer and double vectors are collectively known as numeric vectors.

Lists, which are sometimes called recursive vectors because lists can contain other lists.

The chief difference between atomic vectors and lists is that atomic vectors are homogeneous, while lists can be heterogeneous. There’s one other related object: NULL. NULL is often used to represent the absence of a vector (as opposed to NA which is used to represent the absence of a value in a vector). NULL typically behaves like a vector of length 0. Figure 20.1 summarises the interrelationships.

+++



@snap[north]
Homework session 2
@snapend

@snap[mid text-center text-05]
1. Take a look at the [Tidyverse coding style guide](https://style.tidyverse.org/files.html).
2. Download the [script](https://raw.githubusercontent.com/HenrikEckermann/donders_r/master/donders_course/R/basics.R) and try to understand the content.
3. Then, create 3 vectors: A logical, a character and a numeric one that have an equal length of 5.
4. Create a list that contains all the vectors.
5. Take one of the vectors and select:
   - the last element
   - all except the first element
6. Then take the list and select:
   - the first element as a list 
   - the second element of the third element in the list.
@snapend





---

@snap[mid]
#### Session 3



@snap[mid dtext text-07]
Import data and how to work with dataframes
@snapend

Note:

- what are dataframes 
- how to create dataframes 
- basic properties of dataframes 
- how to import and export data 
- Selecting and filtering your data 
- the pipe operator %>%



+++ 

@snap[west span-45 text-center]
#### What are data frames?
@snapend

@snap[east span-45 text-center text-07]
- THE data structure for most tabular data
- row and columns
- columns are vectors of the same length
- basically a list with named vectors of the same length
@snapend





Note:  
What are data frames?
Data frames are the de facto data structure for most tabular data, and what we use for statistics and plotting.

A data frame can be created by hand, but most commonly they are generated by the functions read.csv() or read.table(); in other words, when importing spreadsheets from your hard drive (or the web).

A data frame is the representation of data in the format of a table where the columns are vectors that all have the same length. Because columns are vectors, each column must contain a single type of data (e.g., characters, integers, factors). For example, here is a figure depicting a data frame comprising a numeric, a character, and a logical vector.



+++ 

#### Create dataframes 

+++

#### Inspect key properties of dataframes

+++

#### Subsetting of dataframes 

+++

#### Import data 

+++

#### Export data 

+++

#### Dplyr Basics


+++

#### The Pipe Operator


+++

@snap[north]
Homework session 3
@snapend

@snap[mid text-center text-05]
1. Go through the script, read the comments and understand the code.
2. Create a new R file in your project and import your own data in R as a dataframe. 
3. How many rows and columns does your dataframe have?
4. What are the datatypes of the vectors within your dataframe?
5. Create another new R file called dataframes.R. Open it. In R, there is a preloaded dataframe called "mtcars". Using only the methods we learned today, try to perform the following actions:
   - Take a look at the first 10 rows and last 10 rows
   - Create a new dataframe that only retains the columns mpg, disp and hp of cars that have 6 cylinders (cyl is the column for the number of cylinders). First use the base R method using the brackets. Then use dplyr functions to achieve the same!
   - if you did not already: answer the same question but use the %>% operator to get to your answer!
   - How many observations are in this new dataframe?
   - export that file to an excel file in your data folder

@snapend


















<!-- session 4 -->

---

@snap[mid]
#### Session 4



@snap[mid dtext text-07]
1. Data transformation and summary
2. Functions
3. Control flow
@snapend

Note:

- mutate 
- group and summarise 
- functions 
- control flow



+++

#### mutate

+++

#### group_by and summarise


+++


@snap[north text-center]
### Write functions
@snapend

@snap[west span-45 text-center]
#### Why & When
@snapend

@snap[east span-45 text-center text-07]
- eliminate chances of mistakes
- make code more structured/readable
- copy/paste code block > 2
- fix mistake in one place 
- Do not repeat yourself!
@snapend

Note:

Do not repeat yourself!



+++

@snap[north text-center]
### Write functions
@snapend

@snap[west span-45 text-center]
#### 3 key steps
@snapend

@snap[east span-45 text-center text-07]
1. Pick a name
2. Determine the arguments
3. Place your code in the body of the function {}
@snapend

Note:  
1. short, clearly evokes what the function does (usually is a verb).
2. 
It is easier to first write the code that works and then make a function out of it than writing a function right away.






+++

@snap[north text-center]
### Conditional execution
@snapend


@snap[midpoint span-60]

```r
if (condition) {
  # code executed when condition is TRUE
} else {
  # code executed when condition is FALSE
}
```

@snapend


Note:  
Do not use | or & but || or && because the former are VECTORIZED operators.



+++

@snap[north text-center]
### Conditional execution
@snapend


@snap[midpoint span-60]

```r
if (this) {
  # do that
} else if (that) {
  # do something else
} else {
  # 
}
```


+++



@snap[north]
Homework session 4
@snapend

@snap[mid text-center text-05]
1. Download the [script](https://github.com/HenrikEckermann/donders_r/blob/master/course_project/R/datamanipulation_and_functions.R) and try to understand the content.
2. Structure and manipulate your own data as far as you can. Also obtain useful summary statistics of your own data by making use of group_by and summarise functions.
3. Write a function that takes as arguments two numeric vectors and returns a named list that shows the Pearson as well as the Spearman correlation of these vectors.
4. Now rewrite this function by giving it another argument (linear = FALSE). Write the function so that it returns Pearson correlation when linear == TRUE and otherwise Spearman correlation.
@snapend