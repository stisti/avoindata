# autot kunnannimillä
autot_kunnat <- merge(autot, kunnat)

# result is an array with named rows
autoja_kunnissa <- tapply(rep(1, length(autot_kunnat$kuntanimi)),
                          autot_kunnat$kuntanimi,
                          sum)

ak <- data.frame(kuntanimi=rownames(autoja_kunnissa), autojen_lkm=autoja_kunnissa)
am <- merge(ak, kuntien_vaesto, by.x = "kuntanimi", by.y = "Alue.2020")
am$tiheys <- am$autojen_lkm / am$Väkiluku..2019

# county with most cars per person
head(am[order(am$tiheys, decreasing = TRUE),c(1,4)])
