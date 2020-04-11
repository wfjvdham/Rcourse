library(openxlsx)

write.xlsx(iris, file = "writeXLSX1.xlsx")
write.xlsx(iris, file = "writeXLSXTable1.xlsx", asTable = TRUE)
