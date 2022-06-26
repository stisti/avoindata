library(httr)
library(readxl)

zip <- GET("http://trafiopendata.97.fi/opendata/TieliikenneAvoinData_5_12.zip")
f_trafi_zip <- file.path("trafi.zip")
writeBin(content(zip, as="raw"), f_trafi_zip)
rm(zip)
dir <- unzip(f_trafi_zip, list=TRUE)
unzip(f_trafi_zip)
autot <- read.csv(dir$Name, header = TRUE, sep = ";", stringsAsFactors = TRUE)

xlsx <- GET("https://www.traficom.fi/sites/default/files/media/file/AjoneuvotiedotMuuttujaluettelo_31_3_2019.xlsx")
f_muuttujat <- file.path("muuttujat.xlsx")
writeBin(content(xlsx, as="raw"), f_muuttujat)
kunnat <- read_excel(f_muuttujat, range = "kunta!A5:B320",
                     col_names = c("kunta", "kuntanimi"),
                     col_types = c("numeric", "text"))

kuntien_vaesto <- read.table("kuntien_vaesto.csv", header = TRUE, sep = ";",
                             encoding = "latin1", skip = 2)

# cleanup
autot$ensirekisterointipvm <- as.Date(autot$ensirekisterointipvm)
