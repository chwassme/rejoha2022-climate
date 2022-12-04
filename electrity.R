library('dplyr')
library('magrittr')
library('lubridate')
library('ISOweek')
library('ggplot2')
library('stringr')


filename <- 'energy.csv'
setwd('/Users/chwassme/dev/dataanalysis/rejoha2022/data/')
getwd()

data <- read.csv2(filename)

data %>% head
summary(data)
names(data)
str(data)

data2 <-
  data %>%
    # head(1000) %>%
    mutate(messzeitpunkt = as.POSIXlt(Start.der.Messung..Text., format = "%Y-%m-%dT%H:%M:%S%z")) %>%
    mutate(datum = (trunc(messzeitpunkt, 'days'))) %>%
    mutate(hour = format.Date(messzeitpunkt, '%H')) %>%
    mutate(week = (isoweek(datum))) %>%
    # mutate(isoweek = ISOweek(datum)) %>%
    mutate(netzlast = as.integer(Netzlast)) %>% # this removes decimal precision, but it's ok
    select(messzeitpunkt, datum, netzlast, hour, week) %>%
    group_by(hour, week) %>%
    summarise(n = n()
      , avg = mean(netzlast)
      , stdev = sd(netzlast)
    )
isoweek(dmy('1.7.2022'))
isoweek(dmy('15.8.2022'))
# ISOweek(dmy('6.7.2022'))
# library(xts)
# xts(data2)

head(data2, 10)
nrow(data2)
names(data2)
data2

isoweek()

ggplot(data2 %>% filter(week >= 25 & week < 33), aes(x = hour, y = avg, group = factor(week))) +
  geom_line(aes(color = factor(week))) +
  scale_color_discrete()
  # scale_color_gradient()
  # scale_color_manual()
  # stat_identity() +
  # scale_shape_manual()


xstr_sub('2011-W52', 7, 8)

ggplot(data2 %>% filter(str_sub(isoweek, 0, 4) == 2018), aes(x = isoweek, y = stdev)) +
  geom_col()


xts(data2$avg, order.by = data$datum)