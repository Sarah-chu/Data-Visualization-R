
#------------------------------------------------------------
# Scatter plot of Corruption and Human development in 2011
#------------------------------------------------------------

# import libraries
install.packages('extrafont')
library(ggplot2)
library(ggthemes)
library(extrafont)
library(data.table)

# import data set
df <- read.csv("Economist_Assignment_Data.csv")

# drop the first column 'X'
df <- df[-1]

head(df)

# create a scatter plot showing CPI and HDI by regions
pl <- ggplot(df, aes(x = CPI, y = HDI, color = Region)) + geom_point(shape = 1, size = 4)
print(pl)

# add a linear regression trend line
pl2 <- pl + geom_smooth(aes(group = 1), method = 'lm', formula = y ~ log(x),, se = FALSE, color = 'red')
pl2

# create a subset for countries to be labelled
pointsToLabel <- c("Russia", "Venezuela", "Iraq", "Myanmar", "Sudan",
                   "Afghanistan", "Congo", "Greece", "Argentina", "Brazil",
                   "India", "Italy", "China", "South Africa", "Spane",
                   "Botswana", "Cape Verde", "Bhutan", "Rwanda", "France",
                   "United States", "Germany", "Britain", "Barbados", "Norway", "Japan",
                   "New Zealand", "Singapore")

# add labels for selected countries
pl3 <- pl2 + geom_text(aes(label = Country), color = "gray20",
                      data = subset(df, Country %in% pointsToLabel), check_overlap = TRUE)
pl3
?geom_text
# add theme and change the elements of x-axis
pl4 <- pl3 + theme_economist_white() + scale_x_continuous(name = 'Corruption Perceptions Index,2011 (10=lease corrupt)',
                                             limits = c(1.4,10.3), breaks = 1:10)
pl4

# change the elements of y-axis
pl5 <- pl4 + scale_y_continuous(name = 'Human Development Index,2011 (1=Best)',
                                limits = c(0.1,1.0), breaks = seq(0, 1, by=0.1))
pl5

# add the title of the scatter plot
pl6 <- pl5 + ggtitle("Corruption and Human development")
pl6
