# I feel like I copy-paste a lot so I want to make a function

- I do the same thing for different `dt`'s -> make a tidy function
- I do the same thing for different columns in my `dt` -> function that works on a column in combination with `across()`
- I do the same thing and it is not on a `dt` (but a `list` (`model`) or `vector`) -> `map()`

## tidy function

- first argument is a dt
- returns a dt
- if column names are given in the arguments use {{}} in the body

Examples: filter(), select()

## function that works on a column

- first argument is the content of a column
- returns a vector the same length as the input or a single value

Examples: mean(), is.na()

## function used with no dt

- any combination of input arguments is possible
- multiple outputs are possible

Examples: get_coef_from_model(), get_eye_colors()

## function vs formula

- function 
  - is better readable when it becomes complex
  - can have multiple input arguments

- formula 
  - more compact
  - usefull for simple things
  - gives you more control on how a function is called