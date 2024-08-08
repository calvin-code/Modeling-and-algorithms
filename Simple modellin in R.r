employee_number <- 1:25
tenure <- c(15, 32, 14, 20, 25, 14, 28, 30, 28, 17, 14, 6, 21, 11, 14, 32, 29, 33, 27, 16, 26, 3, 14, 9, 14)
salary <- c(53908, 78230, 55164, 57647, 63111, 54991, 74571, 73189, 71859, 55978, 61676, 44865, 64676, 59101, 58441, 81964, 76373, 82860, 70019, 58474, 80074, 45594, 63676, 68444, 70306)
data <- data.frame(employee_number, tenure, salary)
plot(data$tenure, data$salary, main="Salary vs. Tenure",
     xlab="Tenure (Years)", ylab="Salary ($)",
     pch=19, col="blue")
model <- lm(salary ~ tenure, data=data)
abline(model, col="red", lwd=2)
summary(model)


install.packages("readxl")
library(readxl)
file_path <- "C:/Users/Cyber/Downloads/Customers Ratings  (2).xlsx"
data <- read_excel(file_path)
model <- lm(CustRate ~ Inc + Age + Educ + Marr, data = data)

summary(model)
model_summary <- summary(model)
beta2_hat <- model_summary$coefficients["Age", "Estimate"]
se_beta2_hat <- model_summary$coefficients["Age", "Std. Error"]
beta2_0 <- 0.05
t_stat <- (beta2_hat - beta2_0) / se_beta2_hat
df <- model_summary$df[2]
alpha <- 0.10
t_critical <- qt(1 - alpha/2, df)
cat("Test Statistic (t):", t_stat, "\n")
cat("Critical Value (t_critical):", t_critical, "\n")
if (abs(t_stat) > t_critical) {
  cat("Reject the null hypothesis: beta2 is significantly different from 0.05 at the 90% confidence level.\n")
} else {
  cat("Do not reject the null hypothesis: beta2 is not significantly different from 0.05 at the 90% confidence level.\n")
}

library(readxl)
data <- read_excel("C:/Users/Cyber/Downloads/Customers Ratings  (2).xlsx")
model <- lm(CustRate ~ Educ, data = data)
summary(model)
conf_interval <- confint(model, level = 0.95)
print(conf_interval)

library(readxl)
data <- read_excel("C:/Users/Cyber/Downloads/Customers Ratings  (2).xlsx")
model <- lm(CustRate ~ Marr, data = data)
summary(model)
conf_interval <- confint(model, level = 0.95)
print(conf_interval)


library(readxl)
data <- read_excel("C:/Users/Cyber/Downloads/Customers Ratings  (2).xlsx")
model <- lm(CustRate ~ Inc + Age + Educ + Marr, data = data)
summary(model)
coefficients <- coef(model)
coefficient_income <- coefficients["Inc"]
increase_income <- 10000
change_customer_rating <- coefficient_income * increase_income
print(change_customer_rating)