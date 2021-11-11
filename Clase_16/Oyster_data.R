# R code used in:
# A protocol for conducting and presenting results of
# regression-type analyses

# Authors: Alain F. Zuur and Elena N. Ieno
# Journal: Methods in Ecology and Evolution (2016)

# Contact information:
# Highland Statistics Ltd.
# www.highstat.com
# highstat@highstat.com
#
#
# This R code is distributed under CC0 license: 
# https://creativecommons.org/publicdomain/zero/1.0/

# The authors (Zuur, Ieno) and Highland Statistics Ltd.
# make no warranties about the R code below, and disclaim 
# liability for all uses of the R code, to the fullest extent 
# permitted by applicable law. 




####################################################
#Figure 3

#Import the data from a tab delimited ascii file
OC <- read.table(file = "OystercatcherData.txt",
                 header = TRUE,
                 dec = ".")

#Inspect the file
names(OC)
str(OC)  # Make sure you have num and not factors for 
# the numerical variables!


# These data were used in:
# Ieno, E.N. & Zuur, A.F. (2015) A Beginner?s 
# Guide to Data Exploration and Visualisation with R. 
# Highland Statistics, Newburgh. 



#################################################################
#Underlying question: 
#         Investigate whether the ShellLength differs
#         per feeding type, feeding plot and season.
#         We may expect a 3-way interaction.


# Here is the code for Figure 3
p <- ggplot()
p <- p + xlab("Feeding type") + ylab("Shell length (mm)")
p <- p + theme(text = element_text(size = 15)) 
p <- p + geom_point(data = OC, 
                    aes(x = FeedingType, y = ShellLength),
                    position = position_jitter(width = .03),
                    color = grey(0.3),
                    size = 2)

p <- p + facet_grid(Month ~ FeedingPlot, 
                    scales = "fixed")
p <- p + theme(legend.position="none") 
p <- p + theme(strip.text.y = element_text(size = 15, 
                                           colour = "black", 
                                           angle = 20),
               strip.text.x = element_text(size = 15, 
                                           colour = "black", 
                                           angle = 0)                            
)
p



# You can also detect the problem in these tables:
table(OC$Month, OC$FeedingPlot, OC$FeedingType)
###########################################