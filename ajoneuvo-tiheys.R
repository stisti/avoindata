# autot kunnannimillä
autot_kunnat <- merge(autot, kunnat)

autoja_kunnissa <- tapply(rep(1, length(autot_kunnat$kuntanimi)),
                          autot_kunnat$kuntanimi,
                          sum)
