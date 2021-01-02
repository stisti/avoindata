# find full electric cars
tayssahko <- autot[autot$kayttovoima == "04",]
hist(tayssahko$ensirekisterointipvm[tayssahko$ensirekisterointipvm > "2010-01-01"],
     seq(as.Date("2010-01-01"), as.Date("2021-01-01"), by="year"),
     freq = TRUE,
     main = "Täyssähköautojen ensirekisteröinnit")
