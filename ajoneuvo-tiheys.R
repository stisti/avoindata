# ajoneuvot kunnannimillä
ank <- merge(an, kunnat)

autotiheys <- tapply(rep(1, length(ank$kuntanimi)), ank$kuntanimi, sum)
