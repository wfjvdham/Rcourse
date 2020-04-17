library(openxlsx)

fit <- lm(Sepal.Length ~ Sepal.Width, iris)

write.xlsx(fit, file = "writeXLSX1.xlsx", sheetName = "fit")
write.xlsx(iris, file = "writeXLSX1.xlsx", sheetName = "data", asTable = TRUE)

getwd()

OUT <- createWorkbook()

# Add some sheets to the workbook
addWorksheet(OUT, "fit")
addWorksheet(OUT, "iris")

# Write the data to the sheets
writeData(OUT, sheet = "fit", x = fit)
writeData(OUT, sheet = "iris", x = iris)

# Export the file
saveWorkbook(OUT, "writeXLSX1.xlsx")

library(broom)

x <- list("fit" = tidy(fit), "data" = iris)

write.xlsx(x, file = "writeXLSX1.xlsx")
