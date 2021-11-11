library(plyr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(lsmeans)
particles <- read.csv(file.choose())

# Find group means
mu <- ddply(particles, "sample", summarise, grp.mean=mean(particlesize))

# Histogram
theme_set(theme_bw(base_size=12,base_family='Times New Roman')+
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank()))
labels <- c(faeces = "Microparticles in Faeces", pseudofaeces = "Microparticles in Pseudofaeces", pure = "Unfed Microparticles")
densityplot <- ggplot(data = particles, aes(x = particlesize, color = sample, fill = sample)) +
  geom_histogram(aes(y=4.8*..density..), position = "identity", alpha = 1, binwidth = 4.8, colour = "black") +
  geom_vline(data = mu, aes(xintercept=grp.mean, color = sample),
             linetype="dashed", colour = "black") +
  scale_fill_discrete(guide=FALSE) +
  labs(x = "Microparticle Diameter (µm)", y = "Proportion of Microparticles", color = "Sample Type") +
  theme(legend.position="none") +
  scale_fill_brewer(palette="Set1") + 
  scale_colour_brewer(palette="Set1") + 
  facet_grid(sample ~ ., labeller=labeller(sample = labels)) +
  theme(panel.border=element_blank(), axis.line=element_line()) +
  theme(strip.background = element_blank())
densityplot

# Statistical comparision of samples using glm
particle_glm <- glm(particlesize ~ sample, family = "poisson", data = particles)
summary(particle_glm)
summary(aov(particle_glm))
# The samples differ significantly
plot(aov(particle_glm))
# Data is all normally distributed so can use standard methods
# Now need to work out which samples specifically differ using least squared means
lsmeans(particle_glm, pairwise ~ sample, adjust="tukey")
# All samples differ significantly

# Statistical comparision of mean values
# Create categories
pure <- filter(particles, sample == "pure")
pseudofaeces <- filter(particles, sample == "pseudofaeces")
faeces <- filter(particles, sample == "faeces")
# mean particle sizes
# pseudofaeces
summarise(pseudofaeces, avg=mean(particlesize), sd=sd(particlesize),n=n(),sem=(sd/sqrt(n())))
# pure
summarise(pure, avg=mean(particlesize), sd=sd(particlesize),n=n(),sem=(sd/sqrt(n())))
# faeces
summarise(faeces, avg=mean(particlesize), sd=sd(particlesize),n=n(),sem=(sd/sqrt(n())))
# Statistical comparision mean values
particle_anova <- aov(particlesize~sample,data=particles)
summary(particle_anova)
boxplot(particlesize~sample,data=particles)
plot(particle_anova)
# Data is normally distributed
# Now test which means specifically differ
TukeyHSD(particle_anova)


# All differ significantly
# Testing as if not normally distributed
kruskal.test(particlesize~sample,data=particles)
# post hoc dunn test
attach(particles)
dunn.test::dunn.test(particlesize,sample)
