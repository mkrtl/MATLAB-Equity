# If this script is run for the first time, delete uncomment lines 2,3 and 4.
#install.packages("foreign")
#install.packages("devtools")
#devtools::install_github("WIDworld/wid-r-tool")
library("wid")
# Get WTID data showing the share of the pre-tax national income and choose data
# is equally divided by spouses. 
# To find other datasets, check ?wid_concepts , ?wid_series_type , ?wid_population_codes
# in console
wtid <- download_wid(indicators = "sptinc", areas = "all", years = "all",
                    perc = "all", ages = "all", pop = "j", metadata = FALSE,
                    verbose = FALSE)

# Eliminate entries with subregions of countries, which have an error code longer than 2
# See also ?wid_population_codes

wtid <-wtid[nchar(wtid$country)<3,]

# Save as csv file : 

write.csv(dta,file = "WTID.csv")

# For further information read pdf of Thomas Blanchet : Download data from WID.world into R 

