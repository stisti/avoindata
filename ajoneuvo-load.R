library(httr)
library(readxl)

zip <- GET("http://trafiopendata.97.fi/opendata/TieliikenneAvoinData_5_12.zip")
f <- file.path("trafi.zip")
writeBin(content(zip, as="raw"), f)
rm(zip)
dir <- unzip(f, list=TRUE)
unzip(f)
an <- read.csv(dir$Name, header = TRUE, sep = ";", stringsAsFactors = TRUE)

xlsx <- GET("https://www.traficom.fi/sites/default/files/media/file/AjoneuvotiedotMuuttujaluettelo_31_3_2019.xlsx")
f_xlsx <- file.path("muuttujat.xlsx")
writeBin(content(xlsx, as="raw"), f_xlsx)


kunnat <- read_excel(f_xlsx, range = "kunta!A5:B320", col_names = c("kunta", "kuntanimi"))

kuntien_vaesto <- read.table("kuntien_vaesto.csv", header = TRUE, sep = ";",
                             encoding = "latin1", skip = 2)

# cleanup
an$ensirekisterointipvm <- as.Date(an$ensirekisterointipvm)
