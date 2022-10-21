## Thesis Christian Schreurs

#install.packages('Synth')
#install.packages('Synthdid')

library(Synth)

# Import data set
df_final <- read.csv("~/Downloads/df_final.csv")


dataprep.out <-
  dataprep(
    foo = df_final
    ,predictors= c("Consumption...per.GDP",
                   "Investment...per.GDP",
                   "Net.exports...per.GDP",
                   "Labour.productivity.growth",
                   "Unemployment.rate")
    ,predictors.op = c("mean")
    ,dependent     = c("Gross.domestic.product..volume..market.prices")
    ,unit.variable = "Countryno"
    ,time.variable = c("Time")
    ,special.predictors = NULL
    ,treatment.identifier  = 25
    ,controls.identifier   = c(1:24)
    ,time.predictors.prior = seq(2015.75, 2016.50, 0.25)
    ,time.optimize.ssr     = seq(1995.00, 2016.50, 0.25)
    ,unit.names.variable   = c("Country")
    ,time.plot            = seq(1995.00, 2020.75, 0.25)
  )

# run synth
synth.out <- synth(data.prep.obj = dataprep.out)

# Get result tables
synth.tables <- synth.tab(
  dataprep.res = dataprep.out,
  synth.res = synth.out
) 

# results tables:
print(synth.tables)

# plot results:
# path
path.plot(synth.res = synth.out,
          dataprep.res = dataprep.out,
          Ylab = c("real per-capita GDP (1986 USD, thousand)"),
          Xlab = c("year"), 
          Ylim = c(-1000,25583501000000), 
          Legend = c("US","Doppelganger"),
) 
