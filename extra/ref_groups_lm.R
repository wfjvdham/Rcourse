#Set Reference Group

# By default the `lm()` function sets the first group of a factor to the reference group, and compares the difference of the other groups with this first one. Using the function `relevel()` you can change this in the following way:

groups <- factor(c("A", "B", "C"))
groups
groups_releveled <- relevel(groups, ref = "B")
groups_releveled

# **Note** this will not change the final predictions you make with the model. It will only allow you to see more easily differences related to a specific group.
