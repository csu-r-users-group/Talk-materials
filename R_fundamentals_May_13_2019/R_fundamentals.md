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

Audience quiz:

# 1. Rstudio

Is this R?

# Rstudio

__NO__- Rstudio is an IDE: __I__ntegrated __D__evelopment
__E__nvironment

Rstudio provides an integrated place to work with R plus many
convience utilities to help with common issues with coding in R.

# 2. tidyverse

Is this R?

# tidyverse

__NO__- the tidyverse primarily is composed of syntactic sugar

What the heck is syntactic sugar?

> In computer science, syntactic sugar is syntax within a programming
> language that is designed to make things easier to read or to
> express. It makes the language "sweeter" for human use: things can be
> expressed more clearly, more concisely, or in an alternative style
> that some may prefer. ~ wikipedia

# 3. R console

Is this R?

# R console

Depends on what you mean by R...

# So, what the heck is R?

R is:

  - A programming language
  
  - An environment to use that language, for a variety of tasks,
    including:
	- statistics
	- visualization
	- data manipulation
	 
  - R can be run *interactively*

# What the heck is R? (cont.)

  - R is procedural (vs. declaritive)
  
  - R is interpretted (vs. compiled)
  
  - Uses lexical scoping (i.e., rules for what variables are visible)
  
  - R supports object-oriented programming
  
# The Read Eval Print Loop

R is interactive.

When you type (or source) code as text, R has to convert this to
machine-operatible instructions. 

To achieve this, R uses a Read Eval Print Loop, or REPL

# REPL

When you start R, it displays the console prompt - it is waiting for
input. 

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
    neverending `+` prompt) 
  - example: `read.csv("myfile.csv)`

3. The command is syntactically correct AND complete

# Eval

Once R determines the command is complete and correct, it evaluates
the command.

Question: Since R is dynamic and interactive, how does it evaluate
`x + y`?

Answer: it has to find the values for `x` and `y` at the time of evaluation

# How R finds variables (and what that means for you)

R relies on the search path to find variables

Since the user can redefine a variable, this has to happen every time
a command is executed.

But in R, everything is a variable (including functions!)

**This is why R is slow compared to compiled languages**

# The search path and you

You can see the current search path with `search()`

R will look inside each of the packages listed in the order listed

R will use the first variable it finds

The longer the search path, the longer the search for functions at the
bottom of the search path

  - base is at the bottom of the search path!

# You can tell R exactly where to look

Helpful if you have four packages which all have a function called "x"

Tell R directly which package with `::`, e.g. `mypackage::x()`

Tempting to think "I will just use `::` for every function!" - makes
code less readable

# Data types in R

There are no scalars in R - everything is a vector

`x = 20`: `x` is a vector of length 1

# Data types:

R supports vectors of:

- numeric

- integer

- logical

- character

# Numeric vs integer

Integers are whole numbers, numeric are any real valued number

For most, int vs numeric is a detail of how these different types are
stored and operated onthat you don't need to worry about.

  - integer value  are limited in the min/max value that can be stored

  - numeric values are subject to machine precision
  
For most work, does not matter (until it does).

# Mixing data types

R will coerse values to be the same when you try to mix types in a
vector. 

To store different types in the same object, you need to use a list

# Lists


