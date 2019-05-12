---
title: "R fundamentals"
author: "Matt Espe"
date: "13 May 2019"
theme: metropolis
---

# Intro

What are fundamentals?

  - _not_ basics: basics cover what you need to know to get started with
    R, and are covered well in many other talks/blog posts/etc.
	
  - fundamentals are foundational: create the low-level understanding
    which helps you to reason about the language.
	
  - many fundamentals involve more advanced topics

# What we will cover today

  - What is R? (don't laugh - its more complicated that you think)

  - The Read Eval Print Loop
  
  - How R finds variables (and what that means for you)
  
  - Data types in R

Definitely not exhaustive or comprehensive - but knowing the above
will help you reason about what R is doing and why.

# What is R?

An audience quiz:

# 1. Rstudio

Is this R?

# Rstudio

__NO__

Rstudio is an IDE: an Integrated Development
Environment

Rstudio provides an integrated place to work with R _plus_ many
convenience utilities to help with common issues with coding in R.

# 2. tidyverse

Is this R?

# tidyverse

__NO__

The tidyverse primarily is composed of syntactic sugar

What the heck is syntactic sugar?


"In computer science, syntactic sugar is syntax within a programming
language that is designed to make things easier to read or to
express. It makes the language 'sweeter' for human use: things can be
expressed more clearly, more concisely, or in an **alternative style
that some may prefer.**" (emphasis added) ~ wikipedia

# 3. R console

Is this R?

# R console

Depends on what you mean by R...

# So, what the heck is R?

R is:

  - A programming language
  
  - An environment to use that language for a variety of tasks
    including:
	- statistics
	- visualization
	- data manipulation
	 
  - R can be run *interactively*

# What the heck is R? (cont.)

  - R is procedural (vs. declarative)
  
  - R is interpreted (vs. compiled)
  
  - Uses lexical scoping (i.e., rules for what variables are visible)
  
  - R supports object-oriented programming
  
# The Read Eval Print Loop

R is interactive.

When you type (or source) code as text, R has to convert this to
machine-operable instructions. 

To achieve this, R uses a *Read Eval Print Loop*, or REPL

# REPL

When you start R, it displays the console prompt - it is waiting for
input. 

When you hit enter, R reads your input, evaluates it, and prints the result

It is a loop - once R completes one command, it returns to waiting for
the next. 

# Read

R reads or _parses_ the text. Depending on the text, there can be 3
possible outcomes:

1. The command contains a syntax error, i.e., it does not make sense 
   - R cannot parse this, results in an error.
   - examples: `x[[1])` results in `Error: unexpected ')' in "x[[1])"` 

2. The command is incomplete
   - R will continue waiting for you to complete the command (i.e., the
    never-ending `+` prompt) 
   - example: `read.csv("myfile.csv)`

3. The command is syntactically correct AND complete

# Eval

Once R determines the command is complete and correct, it evaluates
the command.

Question: Since R is dynamic and interactive, how does it evaluate
`x + y`?

Answer: it has to find the values for `x` and `y` at the time of
evaluation

... but it is more complicated than that. R also has to find `+` (and
yes, if you want to unleash some chaos, you can re-define `+`)

# Print

Once R finishes the operation, it will print the result

If you assign the results to a variable, the printed output is nothing

When you call a variable, the result is just to print the variable

*This is different than messages.* Messages are printed to the
console, but are not the returned result.  

# How R finds variables (and what that means for you)

R relies on the *search path* to find variables

Since the user can re-define a variable, this search has to happen every time
a command is executed.

But in R, everything is a variable (including functions!)

**This is why R is slow compared to compiled languages** It has to
re-find every variable and function every time.

# The search path and you

You can see the current search path with `search()`

R will look inside each of the packages listed in the order listed

R will use the first variable it finds

The longer the search path, the longer the search for functions at the
bottom of the search path

  - base is at the bottom of the search path!

# The search path and you (cont.)

To keep things sane, R uses lexical scoping.

Lots of details we cannot cover here, but

  - functions have a search path that starts internal to the
    function, and proceeds to the function's parent environment

  - packages have a search path that includes package dependencies

# Never ever use attach()

**Just don't. Period.**

... OK, you want to know why. 

`attach()` inserts a copy of an object into your
search path, but not the original object!

# You can tell R exactly where to look

Helpful if you have four packages which all have a function called "x"

Tell R directly which package with `::`
  - e.g. `mypackage::x()`

Tempting to think "I will just use `::` for every function!" - makes
code less readable (and annoying to write)

Better to limit the number of packages that are loaded

# Data types in R

There are no scalars in R - everything is a vector

`x = 20`, `x` is a vector of length 1

Vectors are ordered collections the same type data of some length.

Arrays are ordered collections with multiple dimensions, but are stored by R
as vectors with the dimensions stored as an attribute

Hence, arrays can only contain a single data type.

# Data types:

R supports vectors of:

- numeric

- integer

- logical

- character

- factor (specialized int)

# NA values

Vectors cannot contain different types of data.

Hence, there are different NA's for each data type.

An int NA is NOT the same as a logical NA.

# Numeric vs integer

Integers are whole numbers, numeric are any real valued number

For most, integer vs numeric is a detail of how these different types are
stored and operated on that you don't need to worry about.

  - integer value  are limited in the min/max value that can be stored

  - numeric values are subject to machine precision
  
For most work, does not matter (until it does).

# Mixing data types

R will coerce values to be the same when you try to mix types in a
vector. 

There are rules to this coercion

To store different types in the same object, you need to use a list

# Lists

A list is a collection of different objects.

Each individual object must adhere to the rules of that object type,
e.g. an integer vector only contains integers.

A data.frame is a special type of list where each item is the same
length.

# Conclusions

Once you understand some of the fundamentals of what R is doing, it is
easier to reason about code. 

Otherwise, you default to trial and error - slow, frustrating, and
error prone

There are only a handful more things you need to know to completely
understand R's computational model and master any R code you see (as
long as it is not tidyverse code)


