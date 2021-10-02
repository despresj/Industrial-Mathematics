capacity_frac <- function (p, rooms=100, loss=4, min_p=0.065) {
  E <- 0; E_m1 <- 0; Fx <- 0;
  P_overbook <- 0; bookings <- rooms;
  
  if(p > min_p) {
    while(E_m1 >= E) {
      E <-  bookings * Fx - loss * (bookings - rooms) * bookings * P_overbook
      Fx <-  pbinom(rooms, bookings, p, lower.tail = TRUE)
      bookings <-  bookings + 1
      P_overbook <-  1 - Fx
      E_m1 <-  bookings * Fx - loss * (bookings - rooms) * bookings * P_overbook
    }
  } else {
    bookings = rooms * 10
  }
  return(bookings)
}

capacity_frac(p = 0.04)

