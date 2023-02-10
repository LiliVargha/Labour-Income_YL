
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

####### Towards a typology of intergenerational reallocation patterns: Clustering of countries based on NTA (and NTTA) age profiles
####### by Vargha, Lili & Istenic, Tanja
####### Labour income by age and gender in 39 countries
####### by Vargha, Lili; Binder-Hammer, Bernhard & Donehower, Gretchen & Istenic, Tanja
####### Visualizing country differences to the average age specific labour income
####### by Vargha, Lili; Miller, Timothy

####### Contact: Lili Vargha (lili.vargha@hu-berlin.de or vargha@demografia.hu)
#######

####### Original data source:
####### 1. European AGENTA Project (Istenic et al 2019): http://dataexplorer.wittgensteincentre.org/nta/ for 25 EU countries 2010
####### 2. Counting Women's Work (2022): https://www.countingwomenswork.org/data for countries US, ZA, SN, GH, UY, CO, VN, IN, MX, MU, TG, NE, ML, CI
####### 3. World Population Prospects 2022 (https://population.un.org/wpp/) (United Nations, DESA, Population Division: WPP 2022) and [wpp2022 R package](https://github.com/PPgp/wpp2022)


####### Data downloaded from the AGENTA and CWW website: October 2022

####### Last update: 9 February 2023

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

setwd ("C:/Users/varghali/seadrive_root/Lili Var/My Libraries/My Library/NTA/VIZ")


####### Loading packages

library(tidyverse)
library(readxl)
library(ggplot2)
library(plyr)
library(ggplot2)
library(cowplot)
library(data.table)
library(reshape)
library(patchwork)
library(devtools)
library(qlcMatrix)
library(ggpubr)
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#####
##### reading the European AGENTA data (Istenic et al. 2019): values are already normalized
#####

setwd ("C:/Users/varghali/seadrive_root/Lili Var/My Libraries/My Library/NTA/VIZ")

##### long database downloaded from http://dataexplorer.wittgensteincentre.org/nta/

agenta <- read.csv(file = 'nta2010_long_Norm.csv')


str(agenta)

agenta$sex <- as.factor(agenta$sex)

agenta2 <- agenta[agenta$sex=="total",]

age<- c("0", "10", "20","30", "40", "50", "60", "70", "80")

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#### calculate LCD

agenta$LCD <- agenta$CG + agenta$CF - agenta$YL

#### calculate net transfers

agenta$T <- agenta$TG + agenta$TF

#### calculate asset based reallocation

agenta$AR <- agenta$YA - agenta$S

#### calculate consumption

agenta$C <- agenta$CF + agenta$CG

#### plot LCD and net transfers, asset income (YA), AR

agenta2 <- agenta[agenta$sex=="total",]

#### basic line plots for all countries

ggplot(data=agenta2, aes(x=age, y=LCD, group=country))+
  geom_line()

ggplot(data=agenta2, aes(x=age, y=YA, group=country))+
  geom_line()

ggplot(data=agenta2, aes(x=age, y=T, group=country))+
  geom_line()

ggplot(data=agenta2, aes(x=age, y=AR, group=country))+
  geom_line()

ggplot(data=agenta2, aes(x=age, y=TF, group=country))+
  geom_line()

ggplot(data=agenta2, aes(x=age, y=TG, group=country))+
  geom_line()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###### Reshaping in order to merge with Counting Women's Work Data
######
###### Even though the long format is good for GGPlot, the wide dataset is used for
###### finalizing the order of countries, for calculating differences from AVG age profile and later for clustering

###### We will thus have a merged AGENTA + CWW in both wide and long format

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#### selecting only YL

agenta3 <- select (agenta, c(country, sex, age, YL))

agentamen <- agenta3 %>% filter( sex == "male")
agentawomen <- agenta3 %>% filter( sex == "female")


#### creating wide database of age profiles for men (YL1)

agentamen <- select (agentamen,-c(sex))

agentamen <- reshape(agentamen, idvar = "country", timevar = "age", direction = "wide")

agentamen$country <- revalue(agentamen$country,     c("Austria" = "YL1_AT", "Belgium"="YL1_BE", "Bulgaria"="YL1_BG", "Cyprus"="YL1_CY", "Czech Republic"="YL1_CZ",
                                                      "Estonia"="YL1_EE",   "Finland"="YL1_FI", "France"="YL1_FR", "Germany"="YL1_DE", "Greece"="YL1_GR",
                                                      "Hungary"="YL1_HU", "Ireland"="YL1_IE", "Italy"="YL1_IT", "Latvia"="YL1_LV", "Lithuania"="YL1_LT",
                                                      "Luxembourg"="YL1_LU", "Poland"="YL1_PL", "Portugal"="YL1_PT", "Romania"="YL1_RO", "Slovakia"="YL1_SK",
                                                      "Slovenia"="YL1_SI", "Sweden"="YL1_SE", "United Kingdom"="YL1_UK", "Denmark"="YL1_DK", "Spain"="YL1_ES",
                                                      "EU25 Country Avg."="avg1","EU25 Population Avg."="avg2" ))


#### transpose age profiles for men and make sure they stay numeric values

rownames(agentamen) <- agentamen[,1 ]  
agentamen <- select (agentamen,-c(country))

agentamen <- as.data.frame(t(agentamen), stringsAsFactors = FALSE)
#agentamen <- select (agentamen,-c(avg1,avg2))

#### creating wide database of age profiles for women (YL2)

agentawomen <- select(agentawomen,-c(sex))

agentawomen <- reshape(agentawomen, idvar = "country", timevar = "age", direction = "wide")

agentawomen$country <- revalue(agentawomen$country, c("Austria" = "YL2_AT", "Belgium"="YL2_BE", "Bulgaria"="YL2_BG", "Cyprus"="YL2_CY", "Czech Republic"="YL2_CZ",
                                                      "Estonia"="YL2_EE",   "Finland"="YL2_FI", "France"="YL2_FR", "Germany"="YL2_DE", "Greece"="YL2_GR",
                                                      "Hungary"="YL2_HU", "Ireland"="YL2_IE", "Italy"="YL2_IT", "Latvia"="YL2_LV", "Lithuania"="YL2_LT",
                                                      "Luxembourg"="YL2_LU", "Poland"="YL2_PL", "Portugal"="YL2_PT", "Romania"="YL2_RO", "Slovakia"="YL2_SK",
                                                      "Slovenia"="YL2_SI", "Sweden"="YL2_SE", "United Kingdom"="YL2_UK", "Denmark"="YL2_DK", "Spain"="YL2_ES",
                                                      "EU25 Country Avg."="avg1","EU25 Population Avg."="avg2"))

#### transpose age profiles for women (YL2) and make sure they stay numeric values

rownames(agentawomen) <- agentawomen[,1 ]  
agentawomen <- select (agentawomen,-c(country))
agentawomen <- as.data.frame(t(agentawomen), stringsAsFactors = FALSE)
#agentawomen <- select (agentawomen,-c(avg1,avg2))

#### merge data for men and women age 0-80

agentafinal <- cbind(agentamen, agentawomen)

#### use data point 80+ for ages 81-90+

agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])
agentafinal <- rbind(agentafinal, agentafinal[81,])

#### renaming row names
vec <- 0:90
row.names(agentafinal) <- vec

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#####
##### reading the Counting Women's Work Data (Counting Women's Work 2022)
#####

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


setwd("C:/Users/varghali/seadrive_root/Lili Var/My Libraries/My Library/2020")

cww <- as.data.frame(read_excel("cww_database_PUBLIC_RELEASE_V3.0.xlsx", sheet = "data", range = "B8:JY99"))

str(cww)

#variables my02m: Market labor income, female, LCU per year
#variables my01m: Market labor income, male, LCU per year
#variables mc00m: Market consumption, both sexes, LCU per year
#variables my02t: Time spent with market work, female
#variables my01t: Time spent with market work, male


# for NTA normalization labour income for both sexes combined is needed

# for labour income for both sexes population by age for men and women is needed
# we use UN population Projections for this and its R package: https://github.com/PPgp/wpp2022

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

###
### Population by age and gender: United Nations, DESA, Population Division. World Population Prospects 2022.
###

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#options(timeout = 600)
#install_github("PPgp/wpp2022")
library(wpp2022)

data(pop1dt)
pop1dt
data(popF1)
data(popAge1dt)
str(popAge1dt)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
###Calculating country specific results

###1. For normalization purposes: calculating Labour income age 30-49 (simple average) using CWW and UN data
###2. Calculating normalized labour income for women
###3. Calculating normalized labour income for men
###4. Calculating normalized consumption for men and women
###5. Calculating normalized life cycle deficit/consumption
###6. Plot LCD/LCS & YL age profile by gender for individual countries for check-up

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


###
### US 2009
###

pop_US <- popAge1dt[name=="United States of America" & year==2009]
pop_US2009 <- pop_US[1:91,]

YLavgUS <- (cww$my02mUS * pop_US2009$popF + cww$my01mUS * pop_US2009$popM)/pop_US2009$pop
YLavgUS3049 <- mean(YLavgUS[31:50])
cww$YL1_US <- cww$my01mUS / YLavgUS3049
cww$YL2_US <- cww$my02mUS / YLavgUS3049
cww$C1_US <- cww$mc00mUS /  YLavgUS3049
cww$C2_US <- cww$mc00mUS /  YLavgUS3049
cww$LCD1_US <- cww$C1_US - cww$YL1_US
cww$LCD2_US <- cww$C2_US - cww$YL2_US

plot(cww$age, cww$LCD1_US, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_US, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the US")

plot(cww$age,cww$YL1_US, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_US, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the US")

###
### ZA 2010
###

pop_ZA <- popAge1dt[name=="South Africa" & year==2010]
pop_ZA2010 <- pop_ZA[1:91,]

YLavgZA <- (cww$my02mZA * pop_ZA2010$popF + cww$my01mZA * pop_ZA2010$popM)/pop_ZA2010$pop
YLavgZA3049 <- mean(YLavgZA[31:50])
cww$YL1_ZA <- cww$my01mZA / YLavgZA3049
cww$YL2_ZA <- cww$my02mZA / YLavgZA3049
cww$C1_ZA <- cww$mc00mZA /  YLavgZA3049
cww$C2_ZA <- cww$mc00mZA /  YLavgZA3049
cww$LCD1_ZA <- cww$C1_ZA - cww$YL1_ZA
cww$LCD2_ZA <- cww$C2_ZA - cww$YL2_ZA

plot(cww$age, cww$LCD1_ZA, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_ZA, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the ZA")

plot(cww$age, cww$YL1_ZA, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_ZA, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the ZA")

###
### SN 2011
###

pop_SN <- popAge1dt[name=="Senegal" & year==2011]
pop_SN2011 <- pop_SN[1:91,]

YLavgSN <- (cww$my02mSN * pop_SN2011$popF + cww$my01mSN * pop_SN2011$popM)/pop_SN2011$pop
YLavgSN3049 <- mean(YLavgSN[31:50])
cww$YL1_SN <- cww$my01mSN / YLavgSN3049
cww$YL2_SN <- cww$my02mSN / YLavgSN3049
cww$C1_SN <- cww$mc00mSN /  YLavgSN3049
cww$C2_SN <- cww$mc00mSN /  YLavgSN3049
cww$LCD1_SN <- cww$C1_SN - cww$YL1_SN
cww$LCD2_SN <- cww$C2_SN - cww$YL2_SN

plot(cww$age, cww$LCD1_SN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_SN, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the SN")

plot(cww$age,cww$YL1_SN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_SN, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the SN")

###
### SN 2018
###

pop_SN2 <- popAge1dt[name=="Senegal" & year==2018]
pop_SN22018 <- pop_SN2[1:91,]

YLavgSN2 <- (cww$my02mSN2 * pop_SN22018$popF + cww$my01mSN2 * pop_SN22018$popM)/pop_SN22018$pop
YLavgSN23049 <- mean(YLavgSN2[31:50])
cww$YL1_SN2 <- cww$my01mSN2 / YLavgSN23049
cww$YL2_SN2 <- cww$my02mSN2 / YLavgSN23049
cww$C1_SN2 <- cww$mc00mSN2 /  YLavgSN23049
cww$C2_SN2 <- cww$mc00mSN2 /  YLavgSN23049
cww$LCD1_SN2 <- cww$C1_SN2 - cww$YL1_SN2
cww$LCD2_SN2 <- cww$C2_SN2 - cww$YL2_SN2

plot(cww$age, cww$LCD1_SN2, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_SN2, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the SN2")

plot(cww$age,cww$YL1_SN2, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_SN2, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the SN2")

###
### GH 2009
###

pop_GH <- popAge1dt[name=="Ghana" & year==2009]
pop_GH2009 <- pop_GH[1:91,]

YLavgGH <- (cww$my02mGH * pop_GH2009$popF + cww$my01mGH * pop_GH2009$popM)/pop_GH2009$pop
YLavgGH3049 <- mean(YLavgGH[31:50])
cww$YL1_GH <- cww$my01mGH / YLavgGH3049
cww$YL2_GH <- cww$my02mGH / YLavgGH3049
cww$C1_GH <- cww$mc00mGH /  YLavgGH3049
cww$C2_GH <- cww$mc00mGH /  YLavgGH3049
cww$LCD1_GH <- cww$C1_GH - cww$YL1_GH
cww$LCD2_GH <- cww$C2_GH - cww$YL2_GH

plot(cww$age, cww$LCD1_GH, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_GH, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the GH")

plot(cww$age,cww$YL1_GH, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_GH, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the GH")

###
### UY 2013
###

pop_UY <- popAge1dt[name=="Uruguay" & year==2013]
pop_UY2013 <- pop_UY[1:91,]

YLavgUY <- (cww$my02mUY * pop_UY2013$popF + cww$my01mUY * pop_UY2013$popM)/pop_UY2013$pop
YLavgUY3049 <- mean(YLavgUY[31:50])
cww$YL1_UY <- cww$my01mUY / YLavgUY3049
cww$YL2_UY <- cww$my02mUY / YLavgUY3049
cww$C1_UY <- cww$mc00mUY /  YLavgUY3049
cww$C2_UY <- cww$mc00mUY /  YLavgUY3049
cww$LCD1_UY <- cww$C1_UY - cww$YL1_UY
cww$LCD2_UY <- cww$C2_UY - cww$YL2_UY

plot(cww$age, cww$LCD1_UY, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_UY, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the UY")

plot(cww$age,cww$YL1_UY, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_UY, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the UY")


###
### CO 2009
###

pop_CO <- popAge1dt[name=="Colombia" & year==2012]
pop_CO2012 <- pop_CO[1:91,]

YLavgCO <- (cww$my02mCO * pop_CO2012$popF + cww$my01mCO * pop_CO2012$popM)/pop_CO2012$pop
YLavgCO3049 <- mean(YLavgCO[31:50])
cww$YL1_CO <- cww$my01mCO / YLavgCO3049
cww$YL2_CO <- cww$my02mCO / YLavgCO3049
cww$C1_CO <- cww$mc00mCO /  YLavgCO3049
cww$C2_CO <- cww$mc00mCO /  YLavgCO3049
cww$LCD1_CO <- cww$C1_CO - cww$YL1_CO
cww$LCD2_CO <- cww$C2_CO - cww$YL2_CO

plot(cww$age, cww$LCD1_CO, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_CO, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the CO")

plot(cww$age,cww$YL1_CO, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_CO, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the CO")

###
### VN 2009
###

pop_VN <- popAge1dt[name=="Viet Nam" & year==2015]
pop_VN2015 <- pop_VN[1:91,]

YLavgVN <- (cww$my02mVN * pop_VN2015$popF + cww$my01mVN * pop_VN2015$popM)/pop_VN2015$pop
YLavgVN3049 <- mean(YLavgVN[31:50])
cww$YL1_VN <- cww$my01mVN / YLavgVN3049
cww$YL2_VN <- cww$my02mVN / YLavgVN3049
cww$C1_VN <- cww$mc00mVN /  YLavgVN3049
cww$C2_VN <- cww$mc00mVN /  YLavgVN3049
cww$LCD1_VN <- cww$C1_VN - cww$YL1_VN
cww$LCD2_VN <- cww$C2_VN - cww$YL2_VN

cww$LCD1_VN

plot(cww$age, cww$LCD1_VN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value", )
lines(cww$age, cww$LCD2_VN, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the VN")

plot(cww$age,cww$YL1_VN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_VN, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the VN")


###
### IN 2009
###

pop_IN <- popAge1dt[name=="India" & year==1999]
pop_IN1999 <- pop_IN[1:91,]

YLavgIN <- (cww$my02mIN * pop_IN1999$popF + cww$my01mIN * pop_IN1999$popM)/pop_IN1999$pop
YLavgIN3049 <- mean(YLavgIN[31:50])
cww$YL1_IN <- cww$my01mIN / YLavgIN3049
cww$YL2_IN <- cww$my02mIN / YLavgIN3049
cww$C1_IN <- cww$mc00mIN /  YLavgIN3049
cww$C2_IN <- cww$mc00mIN /  YLavgIN3049
cww$LCD1_IN <- cww$C1_IN - cww$YL1_IN
cww$LCD2_IN <- cww$C2_IN - cww$YL2_IN

plot(cww$age, cww$LCD1_IN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_IN, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the IN")

plot(cww$age,cww$YL1_IN, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_IN, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the IN")

###
### MX 2014
###

pop_MX <- popAge1dt[name=="Mexico" & year==2014]
pop_MX2014 <- pop_MX[1:91,]

YLavgMX <- (cww$my02mMX * pop_MX2014$popF + cww$my01mMX * pop_MX2014$popM)/pop_MX2014$pop
YLavgMX3049 <- mean(YLavgMX[31:50])
cww$YL1_MX <- cww$my01mMX / YLavgMX3049
cww$YL2_MX <- cww$my02mMX / YLavgMX3049
cww$C1_MX <- cww$mc00mMX /  YLavgMX3049
cww$C2_MX <- cww$mc00mMX /  YLavgMX3049
cww$LCD1_MX <- cww$C1_MX - cww$YL1_MX
cww$LCD2_MX <- cww$C2_MX - cww$YL2_MX

plot(cww$age, cww$LCD1_MX, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_MX, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the MX")

plot(cww$age,cww$YL1_MX, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_MX, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the MX")

###
### MU 2003
###

pop_MU <- popAge1dt[name=="Mauritius" & year==2003]
pop_MU2003 <- pop_MU[1:91,]

YLavgMU <- (cww$my02mMU * pop_MU2003$popF + cww$my01mMU * pop_MU2003$popM)/pop_MU2003$pop
YLavgMU3049 <- mean(YLavgMU[31:50])
cww$YL1_MU <- cww$my01mMU / YLavgMU3049
cww$YL2_MU <- cww$my02mMU / YLavgMU3049
cww$C1_MU <- cww$mc00mMU /  YLavgMU3049
cww$C2_MU <- cww$mc00mMU /  YLavgMU3049
cww$LCD1_MU <- cww$C1_MU - cww$YL1_MU
cww$LCD2_MU <- cww$C2_MU - cww$YL2_MU

plot(cww$age, cww$LCD1_MU, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_MU, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the MU")

plot(cww$age,cww$YL1_MU, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_MU, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the MU")

###
### TG 2018
###

pop_TG <- popAge1dt[name=="Togo" & year==2018]
pop_TG2018 <- pop_TG[1:91,]

YLavgTG <- (cww$my02mTG * pop_TG2018$popF + cww$my01mTG * pop_TG2018$popM)/pop_TG2018$pop
YLavgTG3049 <- mean(YLavgTG[31:50])
cww$YL1_TG <- cww$my01mTG / YLavgTG3049
cww$YL2_TG <- cww$my02mTG / YLavgTG3049
cww$C1_TG <- cww$mc00mTG /  YLavgTG3049
cww$C2_TG <- cww$mc00mTG /  YLavgTG3049
cww$LCD1_TG <- cww$C1_TG - cww$YL1_TG
cww$LCD2_TG <- cww$C2_TG - cww$YL2_TG

plot(cww$age, cww$LCD1_TG, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_TG, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the TG")

plot(cww$age,cww$YL1_TG, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_TG, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the TG")


###
### NE 2018
###

pop_NE <- popAge1dt[name=="Niger" & year==2018]
pop_NE2018 <- pop_NE[1:91,]

YLavgNE <- (cww$my02mNE * pop_NE2018$popF + cww$my01mNE * pop_NE2018$popM)/pop_NE2018$pop
YLavgNE3049 <- mean(YLavgNE[31:50])
cww$YL1_NE <- cww$my01mNE / YLavgNE3049
cww$YL2_NE <- cww$my02mNE / YLavgNE3049
cww$C1_NE <- cww$mc00mNE /  YLavgNE3049
cww$C2_NE <- cww$mc00mNE /  YLavgNE3049
cww$LCD1_NE <- cww$C1_NE - cww$YL1_NE
cww$LCD2_NE <- cww$C2_NE - cww$YL2_NE

plot(cww$age, cww$LCD1_NE, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_NE, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the NE")

plot(cww$age,cww$YL1_NE, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_NE, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the NE")

###
### ML 2018
###

pop_ML <- popAge1dt[name=="Mali" & year==2018]
pop_ML2018 <- pop_ML[1:91,]

YLavgML <- (cww$my02mML * pop_ML2018$popF + cww$my01mML * pop_ML2018$popM)/pop_ML2018$pop
YLavgML3049 <- mean(YLavgML[31:50])
cww$YL1_ML <- cww$my01mML / YLavgML3049
cww$YL2_ML <- cww$my02mML / YLavgML3049
cww$C1_ML <- cww$mc00mML /  YLavgML3049
cww$C2_ML <- cww$mc00mML /  YLavgML3049
cww$LCD1_ML <- cww$C1_ML - cww$YL1_ML
cww$LCD2_ML <- cww$C2_ML - cww$YL2_ML

plot(cww$age, cww$LCD1_ML, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_ML, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the ML")

plot(cww$age,cww$YL1_ML, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_ML, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the ML")

###
### CI 2018
###

pop_CI <- popAge1dt[name=="Cote d'Ivoire" & year==2018]
pop_CI2018 <- pop_CI[1:91,]

YLavgCI <- (cww$my02mCI * pop_CI2018$popF + cww$my01mCI * pop_CI2018$popM)/pop_CI2018$pop
YLavgCI3049 <- mean(YLavgCI[31:50])
cww$YL1_CI <- cww$my01mCI / YLavgCI3049
cww$YL2_CI <- cww$my02mCI / YLavgCI3049
cww$C1_CI <- cww$mc00mCI /  YLavgCI3049
cww$C2_CI <- cww$mc00mCI /  YLavgCI3049
cww$LCD1_CI <- cww$C1_CI - cww$YL1_CI
cww$LCD2_CI <- cww$C2_CI - cww$YL2_CI

plot(cww$age, cww$LCD1_CI, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$LCD2_CI, col="red", lwd=3)
abline(h = 0, col = "black")
title("LCD/LCS in the CI")

plot(cww$age,cww$YL1_CI, type="l", col="blue", lwd=3, xlab="age", ylab="normalized value")
lines(cww$age, cww$YL2_CI, col="red", lwd=3)
abline(h = 0, col = "black")
title("YL in the CI")


####### merge with agentafinal dataframe

nta <- cbind(agentafinal, cww)
str(nta)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

####### creating seperate database for time transfers by women and men

YL1var <- c("YL1_US", "YL1_ZA", "YL1_SN", "YL1_GH", "YL1_UY", "YL1_CO", "YL1_VN",
             "YL1_IN", "YL1_MX", "YL1_MU", "YL1_TG", "YL1_NE", "YL1_ML", "YL1_CI", 
             "YL1_HU", "YL1_AT", "YL1_BE", "YL1_BG", "YL1_CY", "YL1_CZ", "YL1_GR",
             "YL1_DE", "YL1_DK", "YL1_EE", "YL1_ES", "YL1_FI", "YL1_FR",  "YL1_IE",
             "YL1_IT", "YL1_LU", "YL1_PT", "YL1_RO", "YL1_SK",  "YL1_LT", "YL1_LV",
             "YL1_PL", "YL1_SE", "YL1_SI", "YL1_UK", "age")

YL2var <- c("YL2_US", "YL2_ZA", "YL2_SN", "YL2_GH", "YL2_UY", "YL2_CO", "YL2_VN",
             "YL2_IN", "YL2_MX", "YL2_MU", "YL2_TG", "YL2_NE", "YL2_ML", "YL2_CI", 
             "YL2_HU", "YL2_AT", "YL2_BE", "YL2_BG", "YL2_CY", "YL2_CZ", "YL2_GR",
             "YL2_DE", "YL2_DK", "YL2_EE", "YL2_ES", "YL2_FI", "YL2_FR",  "YL2_IE",
             "YL2_IT", "YL2_LU", "YL2_PT", "YL2_RO", "YL2_SK",  "YL2_LT", "YL2_LV",
             "YL2_PL", "YL2_SE", "YL2_SI", "YL2_UK", "age")


ntaYL1 <- nta[YL1var]

ntaYL2 <- nta[YL2var]

colnames(ntaYL1)

names(ntaYL1)

####### using the name of the country and year for the visualization


ntaYL1c <- rename(ntaYL1, c("YL1_US"="United States 2009", "YL1_ZA"="South Africa 2010", "YL1_SN"="Senegal 2011", "YL1_GH"="Ghana 2009",
                              "YL1_UY"="Uruguay 2013",       "YL1_CO"="Colombia 2012",     "YL1_VN"="Vietnam 2015", "YL1_IN"="India 1999",
                              "YL1_MX"="Mexico 2014",        "YL1_MU"="Mauritius 2003",    "YL1_TG"="Togo 2018",    "YL1_NE"="Niger 2018",
                              "YL1_ML"="Mali 2018",          "YL1_CI"="Cote d'Ivoire 2018","YL1_HU"="Hungary 2010", "YL1_AT"="Austria 2010",
                              "YL1_BE"="Belgium 2010",       "YL1_BG"="Bulgaria 2010",     "YL1_CY"="Cyprus 2010",  "YL1_CZ"="Czech Republic 2010",
                              "YL1_DE"="Germany 2010",       "YL1_GR"="Greece 2010",       "YL1_IE"="Ireland 2010", "YL1_LU"="Luxembourg 2010",
                              "YL1_DK"="Denmark 2010",       "YL1_EE"="Estonia 2010",      "YL1_ES"="Spain 2010",   "YL1_PT"="Portugal 2010",
                              "YL1_FI"="Finland 2010",       "YL1_FR"="France 2010",       "YL1_IT"="Italy 2010",   "YL1_RO"="Romania 2010",
                              "YL1_LT"="Lithuania 2010",     "YL1_LV"="Latvia 2010",       "YL1_PL"="Poland 2010",  "YL1_SK"="Slovakia 2010",
                              "YL1_SE"="Sweden 2010",        "YL1_SI"="Slovenia 2010",     "YL1_UK"="United Kingdom 2010" ))

ntaYL2c <- rename(ntaYL2, c("YL2_US"="United States 2009", "YL2_ZA"="South Africa 2010", "YL2_SN"="Senegal 2011", "YL2_GH"="Ghana 2009",
                              "YL2_UY"="Uruguay 2013",       "YL2_CO"="Colombia 2012",     "YL2_VN"="Vietnam 2015", "YL2_IN"="India 1999",
                              "YL2_MX"="Mexico 2014",        "YL2_MU"="Mauritius 2003",    "YL2_TG"="Togo 2018",    "YL2_NE"="Niger 2018",
                              "YL2_ML"="Mali 2018",          "YL2_CI"="Cote d'Ivoire 2018","YL2_HU"="Hungary 2010", "YL2_AT"="Austria 2010",
                              "YL2_BE"="Belgium 2010",       "YL2_BG"="Bulgaria 2010",     "YL2_CY"="Cyprus 2010",  "YL2_CZ"="Czech Republic 2010",
                              "YL2_DE"="Germany 2010",       "YL2_GR"="Greece 2010",       "YL2_IE"="Ireland 2010",      "YL2_LU"="Luxembourg 2010",
                              "YL2_DK"="Denmark 2010",       "YL2_EE"="Estonia 2010",      "YL2_ES"="Spain 2010",   "YL2_PT"="Portugal 2010",
                              "YL2_FI"="Finland 2010",       "YL2_FR"="France 2010",       "YL2_IT"="Italy 2010",   "YL2_RO"="Romania 2010",
                              "YL2_LT"="Lithuania 2010",     "YL2_LV"="Latvia 2010",       "YL2_PL"="Poland 2010",  "YL2_SK"="Slovakia 2010",
                              "YL2_SE"="Sweden 2010",        "YL2_SI"="Slovenia 2010",     "YL2_UK"="United Kingdom 2010" ))


rownames(ntaYL1c)
rownames(ntaYL1c) <- ntaYL1c$age
rownames(ntaYL2c) <- ntaYL2c$age


# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

############
############ Preparing YL1 of men for the final GGPlot
############


ntaYL1h <- t(as.matrix(ntaYL1c))

####### deleting row age 
ntaYL1h <- ntaYL1h[-c(40),]

###### general heatmap


colnames(ntaYL1h)

YL1heatmap <- heatmap(ntaYL1h, Rowv=NA, Colv=NA)

####### maximum and minimum values in the matrix
maxYL1 <- max(ntaYL1h)
minYL1 <- min(ntaYL1h)

maxYL1
minYL1

########
########
######## In what order the countries appear on the figure: sorting the countries
########

#1. Sort the data by the maximum place
#max <- as.numeric(max.col(ntaYL1h))
#ntaYL1hs <- cbind(ntaYL1h, max)

#1b. Sort the data by maximum values
max <- as.numeric(rowMax(ntaYL1h))

ntaYL1hs <- cbind(ntaYL1h, max)
ntaYL1hso <- ntaYL1hs[order(-ntaYL1hs[,92]),]

#2. sort the data according to when values turn negative (this method is used in the paper)
#neg1 <- as.numeric(max.col(ntaYL1h < 0,ties.method = "first"))
#neg1


#3. sort the data according to how many ages have negative values
#neg <- as.numeric(rowMeans(ntaYL1h < 0))
#neg


#ntaYL1hs <- cbind(ntaYL1h, neg1)
#ntaYL1hs <- cbind(ntaYL1h, neg2)

#ntaYL1hso <- ntaYL1hs[order(-ntaYL1hs[,92]),]

#4. other sorting is also possible, like alphabetical, etc.

####### making a list of countries in order

ntaYL1hsor <- as.data.frame(ntaYL1hso)
Tborder <- setDT(ntaYL1hsor, keep.rownames = TRUE)[]
names(Tborder)[1] <- "country"

corder <- c(Tborder$country)
corder


####### deleting the sorting coloumn
ntaYL1hso <- ntaYL1hso[,-c(92)]

YL1heatmap <- heatmap(ntaYL1hso, Rowv=NA, Colv=NA)

########
######## GGPLOT is used for the final visualization, so the data has to be restructured
########

YL1df <- as.data.frame(ntaYL1hso)

YL1d <- setDT(YL1df, keep.rownames = TRUE)[]
names(YL1d)[1] <- "country"

######## Reorder Data for ggplot2 plot
YL1melt <- melt(YL1d)

YL1melt
str(YL1melt)

######## Save the restructured data (men) for the plot

save(YL1melt, file="YL1melt.Rdata")

#setwd("C:/Users/varghali/seadrive_root/Lili Var/My Libraries/My Library/2020")
#load("YL1melt.Rdata")

######## Looking at basic heatmap in ggplot

#reorder the country names

YL1melt$country <- factor(x = YL1melt$country,
                          levels = corder, 
                          ordered = TRUE)

age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")

YL1tiles <- ggplot(YL1melt, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", limits = c(0,2.2))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Men",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))                                                          
YL1tiles


############
############ Preparing YL of women for the final GGPlot
############


ntaYL2h <- t(as.matrix(ntaYL2c))

colnames(ntaYL2h)

YL2heatmap <- heatmap(ntaYL2h, Rowv=NA, Colv=NA)

####### deleting row age 
ntaYL2h <- ntaYL2h[-c(40),]

####### maximum and minimum values in the matrix
maxYL2 <- max(ntaYL2h)
minYL2 <- min(ntaYL2h)

maxYL2
minYL2

########
########
######## In what order the countries appear on the figure: sorting the countries
########


#1. Sort the data by the maximum place
max2 <- as.numeric(max.col(ntaYL2h))
#Order according to men's figure
ntaYL2hs <- cbind(ntaYL2h, max)
ntaYL2hso <- ntaYL2hs[order(-ntaYL2hs[,92]),]


#2. sort the data according to when values turn negative
#neg2 <- as.numeric(max.col(ntaYL2h < 0,ties.method = "first"))
#neg2

#replace value of no negative values
#neg <- replace(neg, neg==1, 80)
#neg

#3. sort the data according to how many ages have negative values
#neg <- as.numeric(rowMeans(ntaYL2h < 0))
#neg

#ntaYL2hs <- cbind(ntaYL2h, neg2)

#ntaYL2hso <- ntaYL2hs[order(-ntaYL2hs[,92]),]

#4. Other sorting is also possible

######## Making a list of countries in order

ntaYL2hsor <- as.data.frame(ntaYL2hso)
Tborder <- setDT(ntaYL2hsor, keep.rownames = TRUE)[]
names(Tborder)[1] <- "country"

corder <- c(Tborder$country)
corder

######## deleting the sorting coloumn
ntaYL2hso <- ntaYL2hso[,-c(92)]

YL2heatmap <- heatmap(ntaYL2hso, Rowv=NA, Colv=NA)

########
######## GGPLOT is used for the final visualization, so the data has to be restructured
########

YL2df <- as.data.frame(ntaYL2hso)


YL2d <- setDT(YL2df, keep.rownames = TRUE)[]
names(YL2d)[1] <- "country"

######## Reorder Data for ggplot2 plot
YL2melt <- melt(YL2d)

YL2melt
str(YL2melt)

######## Save the restructured data (women) for the plot

save(YL2melt, file="YL2melt.Rdata")

#setwd("C:/Users/varghali/seadrive_root/Lili Var/My Libraries/My Library/2020")
#load("YL2melt.Rdata")

#reorder the country names 

YL2melt$country <- factor(x = YL2melt$country,
                          levels = corder, 
                          ordered = TRUE)

age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")

YL2tiles <- ggplot(YL2melt, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", , limits = c(0,2.2))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Women",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))                                                          
YL2tiles


############ Patchwork: putting the two plots together


fig <- YL2tiles + YL1tiles

figYL <- fig +
  plot_layout(guides = 'collect')

figYL <- figYL + plot_annotation(
  title = "Labour income by gender in 39 countries",
  theme = theme(plot.title = element_text(size = 18)),
  
  caption = "Data: Istenic et al. 2019, Counting Women's Work
       Replication files & details: https://github.com/LiliVargha/Labour-Income_YL")

figYL

tiff("Outputs/YLbygenderViz2.tiff", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()

jpeg("Outputs/GitHub/YLbygenderViz.jpg", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()

jpeg("Outputs/YLbygenderViz3.jpg", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()



# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


#######
####### Looking for clusters of countries
#######


####### First calculating dissimilarity matrix

####### Using different cluster methods


library(cluster)
library(WeightedCluster)
library(TraMineR)

library(factoextra)
library(ggplot2)
library(heatmaply)

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Merging database of men and women: 1. for clustering, 2. for gender wage gap

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

nta1 <- as.matrix(ntaYL1hso)
nta2 <- as.matrix(ntaYL2hso)

#combined YL for men and women
ntamatrix <- cbind(nta1,nta2)
str(ntamatrix)

#gender labour income gap

#ntamatrix <- (nta1 - nta2)/nta1
#ntamatrix <- ntamatrix*100

####### Standardise the age specific variables

ntamatrix <- scale(ntamatrix)

####### Euclidean (default) and the sum of absolute distances (manhattan)

YLdismatrix <- as.matrix(daisy(ntamatrix))
YLdismatrix2 <- as.matrix(daisy(ntamatrix, metric = "manhattan"))

str(YLdismatrix)

YLdismatrix[1:5,1:5]

####### Hierarchical clustering 

cluster1 <- hclust(as.dist(YLdismatrix), 
                   method = "ward.D")

cluster2 <- hclust(as.dist(YLdismatrix2), 
                   method = "ward.D")


#plot the dendrogram

plot(cluster1, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")

plot(cluster2, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")


wardtest1 <- as.clustrange(cluster1,
                           diss=YLdismatrix,
                           ncluster=9)

wardtest2 <- as.clustrange(cluster2,
                           diss=YLdismatrix,
                           ncluster=10)
wardtest1
wardtest2

plot(wardtest1, norm="zscore", lwd=4)


#elbow method

#fviz_nbclust(YLdismatrix, FUN = hcut, method = "wss",
#barfill = "black",
#barcolor = "black",
#linecolor = "black")

#fviz_nbclust(YLdismatrix, FUN = hcut, method = "silhouette",
#barfill = "black",
#barcolor = "black",
#linecolor = "black")

#fviz_nbclust(YLdismatrix2, FUN = hcut, method = "silhouette",
#barfill = "black",
#barcolor = "black",
#linecolor = "black")

#choosing 3 clusters

cluster1.3 <- cutree(cluster1, 
                     k = 3)

cluster1.3

summary(silh.ward <- silhouette(cluster1.3, dmatrix = YLdismatrix))

plot(silh.ward, 
     main = "Silhouette WARD solution", 
     col = "blue",
     border = NA)

#choosing 2 clusters

cluster1.2 <- cutree(cluster1, 
                     k = 2)

cluster1.2

summary(silh.ward <- silhouette(cluster1.2, dmatrix = YLdismatrix))

plot(silh.ward, 
     main = "Silhouette WARD solution", 
     col = "blue",
     border = NA)

#choosing 4 clusters

cluster1.4 <- cutree(cluster1, 
                     k = 4)

cluster1.4

summary(silh.ward <- silhouette(cluster1.4, dmatrix = YLdismatrix))

plot(silh.ward, 
     main = "Silhouette WARD solution", 
     col = "blue",
     border = NA)

#test different cluster solutions

pam <- wcKMedRange(YLdismatrix, 
                   kvals = 2:15)

#print the quality test for different cluster solutions

pam 

#apply the PAM-clustering algorithm

pam6 <- wcKMedoids(YLdismatrix, 
                   k = 6)

pam6 <- pam6$clustering 

table(pam6)

pam2


# checking different clustering techniques: ward method seems the best
proxmat <- dist(YLdismatrix, method = 'euclidean')

m <- c( "average", "single", "complete", "ward")
names(m) <- c( "average", "single", "complete", "ward")

ac <- function(x) {
  agnes(YLdismatrix, method = x)$ac
}

map_dbl(m, ac)

# choosing 3 cluster solution for plotting

YL1d$cluster3 <-  as.factor(cluster1.3)

YLmelt <- melt(YL1d)
YLmelt

ggplot(data=YLmelt, aes(x=variable, y=value, group=country))+
  geom_line()


# The palette with grey:
cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
                   "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
                   
# The palette with black:
cbp2 <- c("#000000", "#E69F00", "#56B4E9", "#009E73",
                   "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
                   
age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")


YLmelt$variable <- as.numeric(YLmelt$variable)
fig1 <- ggplot(data=YLmelt, aes(x=variable, y=value, group=country, color=cluster3)) +
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("red", "navy", "#00AFBB"), name  ="3 Clusters",
                     breaks=c("1", "2", "3"),
                     labels=c("Highest gender gap and higher old age YL (N=5)", "Medium level gender gap and higher old age YL (N=6)", "Smallest gender gap, low old age YL (N=28)")) +
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(0, 90, by=10), labels=(age)) +
  labs(title="Men") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"),
        axis.text.x=element_text(size=12)) +
  theme(legend.position="bottom") +
  guides(color = guide_legend(nrow = 3)) +
  theme(axis.text.y = element_text(size = 12)) +
  theme(plot.subtitle = element_text(size=12)) +
  theme(plot.title = element_text(size=16)) +
  theme(axis.title.x = element_text(size=14)) +
  theme(axis.title.y = element_text(size=14)) +
  theme(plot.caption = element_text(size=12)) +
  theme(legend.title = element_text(size = 16),
        legend.text = element_text(size = 16)) +
  scale_y_continuous(name="Normalized Value", limits=c(0,2.2) )

fig1 

YL2d$cluster3 <-  as.factor(cluster1.3)

YLmelt <- melt(YL2d)
YLmelt

ggplot(data=YLmelt, aes(x=variable, y=value, group=country))+
  geom_line()


age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")


YLmelt$variable <- as.numeric(YLmelt$variable)
fig2 <- ggplot(data=YLmelt, aes(x=variable, y=value, group=country, color=cluster3)) +
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("red", "navy", "#00AFBB"), name  ="3 Clusters",
                     breaks=c("1", "2", "3"),
                     labels=c("Highest gender gap and higher old age YL (N=5)", "Medium level gender gap and higher old age YL (N=6)", "Smallest gender gap, low old age YL (N=28)")) +
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(0, 90, by=10), labels=(age)) +
  labs(title="Women") +
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"),
        axis.text.x=element_text(size=12)) +
  theme(legend.position="bottom") +
  guides(color = guide_legend(nrow = 3)) +
  theme(axis.text.y = element_text(size = 12)) +
  theme(plot.subtitle = element_text(size=12)) +
  theme(plot.title = element_text(size=16)) +
  theme(axis.title.x = element_text(size=14)) +
  theme(axis.title.y = element_text(size=14)) +
  theme(plot.caption = element_text(size=12)) +
  theme(legend.title = element_text(size = 16),
        legend.text = element_text(size = 16)) +
  scale_y_continuous(name="Normalized Value", limits=c(0,2.2) )

fig2 


figc <- fig2 + fig1

figYL <- figc +
  plot_layout(guides = 'collect') & theme(legend.position = 'bottom')

figYL <- figYL + plot_annotation(
  title = "3 Clusters for gender specific labour income age profiles (N=39)",
  caption = "Data: Istenic et al. 2019, Counting Women's Work
       Replication files & details: https://github.com/LiliVargha/Labour-Income_YL",
  theme = theme(plot.title = element_text(size = 18)))


figYL


tiff("Outputs/YLbygenderClusterv2.tiff", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()

jpeg("Outputs/GitHub/YLbygenderCluster.jpg", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()



####### YL tiles with new order

ord <- cbind(corder,cluster1.3)
ord
str(ord)
?order
ord <-ord[order(ord[,2], decreasing = FALSE),]

corder2<-ord[,1]


YL1melt$country <- factor(x = YL1melt$country,
                          levels = corder2, 
                          ordered = TRUE)

age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")

YL1tiles <- ggplot(YL1melt, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", limits = c(0,2.2))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Men",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))                                                          
YL1tiles

YL2melt$country <- factor(x = YL2melt$country,
                          levels = corder2, 
                          ordered = TRUE)

age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")

YL2tiles <- ggplot(YL2melt, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", , limits = c(0,2.2))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Women",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))                                                          
YL2tiles

fig <- YL2tiles + YL1tiles

figYL <- fig +
  plot_layout(guides = 'collect')

figYL <- figYL + plot_annotation(
  title = "Labour income by gender in 39 countries",
  caption = "Data: Istenic et al. 2019, Counting Women's Work
       Replication files & details: https://github.com/LiliVargha/Labour-Income_YL",
  theme = theme(plot.title = element_text(size = 18)))




figYL

tiff("Outputs/YLbygenderVizCLUSTER.tiff", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()

jpeg("Outputs/GitHub/YLbygenderVizCLUSTER.jpg", units="in", width=20, height=6, res=500)
plot(figYL, align="h", rel_widths=c(1,0.2))
dev.off()

cluster1.3

####### Dissmilarity/distance matrix, NTAYLhso for men

ntamatrix <- as.matrix(ntaYL1hso)

str(ntamatrix)

####### Standardise the age specific variables

ntamatrix <- scale(ntamatrix)

####### Euclidean (default) and the sum of absolute distances (manhattan)

YLdismatrix <- as.matrix(daisy(ntamatrix))
YLdismatrix2 <- as.matrix(daisy(ntamatrix, metric = "manhattan"))

str(YLdismatrix)

YLdismatrix[1:5,1:5]

####### Hierarchical clustering 

cluster1 <- hclust(as.dist(YLdismatrix), 
                   method = "ward.D")

cluster2 <- hclust(as.dist(YLdismatrix2), 
                   method = "ward.D")
?hclust

#plot the dendrogram

plot(cluster1, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")

plot(cluster2, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")


wardtest1 <- as.clustrange(cluster1,
                           diss=YLdismatrix,
                           ncluster=9)

wardtest2 <- as.clustrange(cluster2,
                           diss=YLdismatrix,
                           ncluster=10)
wardtest1
wardtest2

#choosing 2 clusters

cluster1.2 <- cutree(cluster1, 
                     k = 2)

cluster1.2

summary(silh.ward <- silhouette(cluster1.2, dmatrix = YLdismatrix))

plot(silh.ward, 
     main = "Silhouette WARD solution", 
     col = "blue",
     border = NA)

cluster1.2
str(cluster1.2)

YL1df <- as.data.frame(ntaYL1hso)

YL1d <- setDT(YL1df, keep.rownames = TRUE)[]
names(YL1d)[1] <- "country"

YL1d$cluster2 <-  as.factor(cluster1.2)


YLmelt <- melt(YL1d)
YLmelt

ggplot(data=YLmelt, aes(x=variable, y=value, group=country))+
  geom_line()


# The palette with grey:
cbp1 <- c("#999999", "#E69F00", "#56B4E9", "#009E73",
                   "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
                   
# The palette with black:
cbp2 <- c("#000000", "#E69F00", "#56B4E9", "#009E73",
                   "#F0E442", "#0072B2", "#D55E00", "#CC79A7")
                   
age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")
                   

YLmelt$variable <- as.numeric(YLmelt$variable)
fig <- ggplot(data=YLmelt, aes(x=variable, y=value, group=country, color=cluster2)) +
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("red", "#00AFBB"), name  ="2 Clusters",
                     breaks=c("1", "2"),
                     labels=c("Cluster 1", "Cluster 2")) +
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(0, 90, by=10), labels=(age)) +
  labs(title="Labour Income Age Profile Clusters, Men (N=39)") +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"),
        axis.text.x=element_text(size=12)) +
  theme(axis.text.y = element_text(size = 12)) +
  theme(plot.subtitle = element_text(size=12)) +
  theme(plot.title = element_text(size=16)) +
  theme(axis.title.x = element_text(size=14)) +
  theme(axis.title.y = element_text(size=14)) +
  theme(plot.caption = element_text(size=12)) +
  theme(legend.title = element_text(size = 12),
        legend.text = element_text(size = 12)) +
  scale_y_continuous(name="Normalized Value", limits=c(0,2.2) )

fig 

jpeg("Outputs/ClusterYL1.jpg", units="in", width=10, height=6, res=500)
plot(fig, align="h", rel_widths=c(1,0.2))
dev.off()


####### Dissmilarity/distance matrix, NTAYLhso for women

ntamatrix <- as.matrix(ntaYL2hso)

str(ntamatrix)

####### Standardise the age specific variables

ntamatrix <- scale(ntamatrix)

####### Euclidean (default) and the sum of absolute distances (manhattan)

YLdismatrix <- as.matrix(daisy(ntamatrix))
YLdismatrix2 <- as.matrix(daisy(ntamatrix, metric = "manhattan"))

str(YLdismatrix)

YLdismatrix[1:5,1:5]

####### Hierarchical clustering 

cluster1 <- hclust(as.dist(YLdismatrix), 
                   method = "ward.D")

cluster2 <- hclust(as.dist(YLdismatrix2), 
                   method = "ward.D")
?hclust

#plot the dendrogram

plot(cluster1, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")

plot(cluster2, 
     labels = FALSE, 
     ylab="Dissimilarity threshold")


wardtest1 <- as.clustrange(cluster1,
                           diss=YLdismatrix,
                           ncluster=9)

wardtest2 <- as.clustrange(cluster2,
                           diss=YLdismatrix,
                           ncluster=10)
wardtest1
wardtest2

#choosing 3 clusters

cluster1.3 <- cutree(cluster1, 
                     k = 3)

cluster1.3

summary(silh.ward <- silhouette(cluster1.3, dmatrix = YLdismatrix))

plot(silh.ward, 
     main = "Silhouette WARD solution", 
     col = "blue",
     border = NA)

cluster1.3
str(cluster1.3)

YL2df <- as.data.frame(ntaYL2hso)

YL2d <- setDT(YL2df, keep.rownames = TRUE)[]
names(YL2d)[1] <- "country"

YL2d$cluster3 <-  as.factor(cluster1.3)

YLmelt <- melt(YL2d)
YLmelt

ggplot(data=YLmelt, aes(x=variable, y=value, group=country))+
  geom_line()


age<- c("0", "10", "20","30", "40", "50", "60", "70", "80", "90+")


YLmelt$variable <- as.numeric(YLmelt$variable)
fig <- ggplot(data=YLmelt, aes(x=variable, y=value, group=country, color=cluster3)) +
  geom_line() +
  theme_minimal() +
  scale_color_manual(values = c("red", "navy", "#00AFBB"), name  ="3 Clusters",
                     breaks=c("1", "2", "3"),
                     labels=c("Cluster 1", "Cluster 2", "Cluster3")) +
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(0, 90, by=10), labels=(age)) +
  labs(title="Labour Income Age Profile Clusters, Women (N=39)") +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"),
        axis.text.x=element_text(size=12)) +
  theme(axis.text.y = element_text(size = 12)) +
  theme(plot.subtitle = element_text(size=12)) +
  theme(plot.title = element_text(size=16)) +
  theme(axis.title.x = element_text(size=14)) +
  theme(axis.title.y = element_text(size=14)) +
  theme(plot.caption = element_text(size=12)) +
  theme(legend.title = element_text(size = 12),
        legend.text = element_text(size = 12)) +
  scale_y_continuous(name="Normalized Value", limits=c(0,2.2) )

fig 

jpeg("Outputs/cluster/ClusterYL1.jpg", units="in", width=10, height=6, res=500)
plot(fig, align="h", rel_widths=c(1,0.2))
dev.off()

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

############
############ Visualizing differences from the country avg age profiles
############ 

# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NTAYL1h <- ntaYL1h

colMeans(NTAYL1h)
AVG <- colMeans(NTAYL1h)
NTAYL1dif <- sweep(NTAYL1h,2,AVG)

YL1difdf <- as.data.frame(NTAYL1dif)

YL1difdf2 <- setDT(YL1difdf, keep.rownames = TRUE)[]
names(YL1difdf2)[1] <- "country"

##maximum and minimum values in the matrix
maxYL1dif <- max(NTAYL1dif)
minYL1dif <- min(NTAYL1dif)

maxYL1dif
minYL1dif

NTAYL1difs <- cbind(NTAYL1dif, max)

NTAYL1difso <- NTAYL1difs[order(-NTAYL1difs[,92]),]

#making a list of countries in order

NTAYL1difsor <- as.data.frame(NTAYL1difso)
Tborder <- setDT(NTAYL1difsor, keep.rownames = TRUE)[]
names(Tborder)[1] <- "country"

corder <- c(Tborder$country)
corder

#deleting the sorting coloumn
NTAYL1difso <- NTAYL1difso[,-c(92)]

YL1difeatmap <- heatmap(NTAYL1difso, Rowv=NA, Colv=NA)

####GGPLOT

#restructuring the data
YL1df <- as.data.frame(NTAYL1difso)

YL1d <- setDT(YL1df, keep.rownames = TRUE)[]
names(YL1d)[1] <- "country"


#Reshape Data for ggplot2 plot
YL1difmelt_o <- melt(YL1d)

#reorder the country names 

YL1difmelt_o$country <- factor(x = YL1difmelt_o$country,
                               levels = corder, 
                               ordered = TRUE)

YL1diftiles_o <- ggplot(YL1difmelt_o, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", limits = c(-0.6,1))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Men",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))  
YL1diftiles_o




figYL2

NTAYL2h <- ntaYL2h

colMeans(NTAYL2h)
AVG <- colMeans(NTAYL2h)
NTAYL2dif <- sweep(NTAYL2h,2,AVG)

YL2difdf <- as.data.frame(NTAYL2dif)

YL2difdf2 <- setDT(YL2difdf, keep.rownames = TRUE)[]
names(YL2difdf2)[1] <- "country"

##maximum and minimum values in the matrix
maxYL2dif <- max(NTAYL2dif)
minYL2dif <- min(NTAYL2dif)

maxYL2dif
minYL2dif

NTAYL2difs <- cbind(NTAYL2dif, max)

NTAYL2difso <- NTAYL2difs[order(-NTAYL2difs[,92]),]

#making a list of countries in order

NTAYL2difsor <- as.data.frame(NTAYL2difso)
Tborder <- setDT(NTAYL2difsor, keep.rownames = TRUE)[]
names(Tborder)[1] <- "country"

corder <- c(Tborder$country)
corder

#deleting the sorting coloumn
NTAYL2difso <- NTAYL2difso[,-c(92)]

YL2difeatmap <- heatmap(NTAYL2difso, Rowv=NA, Colv=NA)

####GGPLOT

#restructuring the data
YL2df <- as.data.frame(NTAYL2difso)

YL2d <- setDT(YL2df, keep.rownames = TRUE)[]
names(YL2d)[1] <- "country"


#Reshape Data for ggplot2 plot
YL2difmelt_o <- melt(YL2d)

#reorder the country names 

YL2difmelt_o$country <- factor(x = YL2difmelt_o$country,
                               levels = corder, 
                               ordered = TRUE)

YL2diftiles_o <- ggplot(YL2difmelt_o, aes(x=as.numeric(variable), y=country))+
  geom_tile(aes(fill=value), colour="White", linewidth=0.45)+
  theme_classic()+
  scale_fill_distiller(palette="Spectral", limits = c(-0.6,1))+
  scale_y_discrete(name="", expand=c(0,0))+
  scale_x_continuous(name="Age", expand=c(0,0), breaks=seq(1, 91, by=10), labels=(age))+
  labs(title="Women",
       caption="")+
  theme(plot.title = element_text(hjust = 0.5)) +
  theme(axis.line.y=element_blank(), plot.subtitle=element_text(size=rel(0.78)), plot.title.position="plot",
        axis.text.y=element_text(colour="Black"))  
YL2diftiles_o

jpeg("Outputs/dif/YL2diftiles_o.jpg", units="in", width=14, height=16, res=500)
plot_grid(YL2diftiles_o, align="h", rel_widths=c(1,0.2))
dev.off()  

fig4 <- YL2diftiles_o + YL1diftiles_o 

fig2dif <- fig4 +
  plot_layout(guides = 'collect')
fig2dif

figdif <- fig2dif + plot_annotation(
  title = "Difference between age specific YL of women/men & age specific 39 country average YL of women/men",
  theme = theme(plot.title = element_text(size = 18)),
  
  caption = "Data: Istenic et al. 2019, Counting Womens Work 2022
  Replication files & details: https://github.com/LiliVargha/Labour-Income_YL")
figdif

tiff("Outputs/YLDIFbygenderVizCLUSTER.tiff", units="in", width=20, height=6, res=500)
plot(figdif, align="h", rel_widths=c(1,0.2))
dev.off()

jpeg("Outputs/GitHub/YLDIFbygenderVizCLUSTER.jpg", units="in", width=20, height=6, res=500)
plot(figdif, align="h", rel_widths=c(1,0.2))
dev.off()
