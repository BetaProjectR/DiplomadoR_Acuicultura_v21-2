library(dplyr)
library(tidyr)
library(ggplot2)

clearance <- read.csv(file.choose())

# Create data filters
mussel <- filter(clearance, sample == "mussel")
control <- filter(clearance, sample == "control")

# Create regression lines
reg_mussel <- lm(log_microparticle_concentration ~ time, data=mussel)
summary(reg_mussel)
reg_control <- lm(log_microparticle_concentration ~ time, data=control)
summary(reg_control)

## Microparticle concentration vs time
# Plotting microparticle concentration vs time
theme_set(theme_bw(base_size=12,base_family='Times New Roman')+
            theme(panel.grid.major = element_blank(), 
                  panel.grid.minor = element_blank()))
microplot <- ggplot(data = clearance, aes(x = time, y = log_microparticle_concentration, color = sample, shape = sample)) +
  geom_point(position = position_jitter(w = 0, h = 0.1) ) +
  labs(x = "Time (minutes)", y = expression(log[10]~(Microparticle~Concentration~(microparticles~ml^-1)))) +
  stat_smooth(method='lm',formula=y~x, se=F) +
  scale_shape_manual(values=c(1,2)) +
  scale_color_brewer(palette="Set1") + 
  theme(legend.position="none") +
  theme(panel.border=element_blank(), axis.line=element_line())
microplot

# Statistics to compare microparticle concentration vs time between mussels and controls
# Use an ANCOVA to test for differences in slope and intercept between regression lines
lm.full <- lm(log_microparticle_concentration ~ time*sample + time + sample, data = clearance)
summary(lm.full)
lm.add <- lm(log_microparticle_concentration ~ time + sample, data = clearance)
anova(lm.full,lm.add)
# Output shows that the interaction between time and sample is significant, so the slopes are different, so cannot drop interaction.  Doesn't test if the intercepts are different.

# Statistics for significance of fall in microparticle concentration with time
glm.mussel <- lm(microparticle_concentration ~ time, data = mussel)
summary(glm.mussel)
# Output shows fall in microparticle concentration with time is very significant for mussels
glm.control <- lm(microparticle_concentration ~ time, data = control)
summary(glm.control)
# Output shows fall in microparticle concentration with time is significant for controls

# Mean start and finish microparticle concentrations
# mussel mean starting concentration
mussel_startconc <- filter(mussel, time == 0)
summarise(mussel_startconc, avg=mean(microparticle_concentration), sd=sd(microparticle_concentration),n=n(),sem=(sd/sqrt(n())))
# mussel mean end concentration
mussel_endconc <- filter(mussel, time == 60)
summarise(mussel_endconc, avg=mean(microparticle_concentration), sd=sd(microparticle_concentration),n=n(),sem=(sd/sqrt(n())))
# control mean starting concentration
control_startconc <- filter(control, time == 0)
summarise(control_startconc, avg=mean(microparticle_concentration), sd=sd(microparticle_concentration),n=n(),sem=(sd/sqrt(n())))
# control mean end concentration
control_endconc <- filter(control, time == 60)
summarise(control_endconc, avg=mean(microparticle_concentration), sd=sd(microparticle_concentration),n=n(),sem=(sd/sqrt(n())))

# Test if final microparticle concentration significantly lower in mussels than controls
# Need to create an ANOVA with the start and end concentrations
start_end <- filter(clearance, time == 60 | time == 0)
start_end$time <- factor(start_end$time)
lm.start_end <- lm(microparticle_concentration ~ as.factor(time)*sample + as.factor(time) + sample, data = start_end)
summary(lm.start_end)

# Clearance rates per unit wet mussel mass
# Statistics for significance of fall in clearance rates with time
lm.mussel <- lm(controlcorrected_clearance_per_mass ~ time, data = mussel)
summary(lm.mussel)
# Fall in clearance rates is sigmificant

# Statistics for significance of fall in clearance rates with microparticle concentration
lm.mussel <- lm(controlcorrected_clearance_per_mass ~ microparticle_concentration, data = mussel)
summary(lm.mussel)
# Fall in clearance rates is sigmificant

# Mean clearance rates at each time interval
rate0 <- filter(mussel, time == 0)
summarise(rate0, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate5 <- filter(mussel, time == 5)
summarise(rate5, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate10 <- filter(mussel, time == 10)
summarise(rate10, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate15 <- filter(mussel, time == 15)
summarise(rate15, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate20 <- filter(mussel, time == 20)
summarise(rate20, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate25 <- filter(mussel, time == 25)
summarise(rate25, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate30 <- filter(mussel, time == 30)
summarise(rate30, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate35 <- filter(mussel, time == 35)
summarise(rate35, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate40 <- filter(mussel, time == 40)
summarise(rate40, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate45 <- filter(mussel, time == 45)
summarise(rate45, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate50 <- filter(mussel, time == 50)
summarise(rate50, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))
rate55 <- filter(mussel, time == 55)
summarise(rate55, avg=mean(controlcorrected_clearance_per_mass), sd=sd(controlcorrected_clearance_per_mass),n=n(),sem=(sd/sqrt(n())))




