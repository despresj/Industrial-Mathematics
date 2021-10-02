library(tidyverse)
library(patchwork)
library(lubridate)
library(extrafont)
library(latex2exp)
theme_set(theme_light())
source(here::here("R", "capacity_frac.R"))


figure1 <- tibble(p = seq(from = 0.001, to = 1, by = 0.001)) %>% 
  mutate(bookings = map_dbl(p, capacity_frac, 100, 4, 0.0001)) %>% 
  ggplot(aes(x = p, 
             y = bookings, 
             color = bookings > 1e3, 
             linetype = bookings > 1e3)) + 
  geom_line() + 
  scale_x_reverse(breaks = c(1, 0.75, 0.5, 0.25, 0.065, 0)) + 
  scale_y_log10(labels=scales::comma_format(), limits = c(100, 1e4),
                breaks = c(100, 1e3, 1e4, 1e5)) + 
  labs(title = NULL,
       y = TeX("Optimum Number of Bookings to Make $b^*$"),
       x = TeX("Probability of a Guest's Arrival $\\hat{p}$"),
       color =  NULL, 
       linetype = NULL) +
  annotate("point", 
           x = 0.0665,
           y = 1000,
           colour = "red", size=2, alpha=0.8) + 
  scale_linetype_manual(values=c("solid", "twodash"))+
  scale_color_manual(values=c('black','red')) + 
  theme(legend.position="none") + 
  theme(text=element_text(family="Arial", size=9)) 

figure1

ggsave(here::here("R","figures", "Figure1.png"), 
       height = 11/3, width = 8.5) # 1/3 of a page

capacity_frac(0.065)

# fig 2 -------------------------------------------------------------------


sim_results <- here::here("data", "sim_results.csv") %>% 
  readr::read_csv()

overbooking <- sim_results %>% 
  ggplot(aes(x = check_in_date, y = over_booking_arrivals)) + 
  geom_point(aes(color = over_booking_arrivals > 100)) +
  geom_line() + 
  geom_hline(yintercept = 100, linetype = "dashed", color = "red", alpha = 0.8) + 
  scale_y_continuous(limits = c(0, 135)) +
  theme(legend.position = "bottom") + 
  labs(title = "Overbooking Strategy", x = NULL, y = "Simulated Guests Arrivals") + 
  scale_color_manual(values = c("black", "red")) +
  theme(legend.position = "none") 

no_overbooking <- sim_results %>%
  ggplot(aes(x = check_in_date, y = booking_arrivals)) +
  geom_point(aes(color = booking_arrivals > 100), size = 1) +
  geom_line() +
  geom_hline(yintercept = 100, linetype = "dashed", color = "red", alpha = 0.8) +
  scale_color_manual(values = c("black")) +
  scale_y_continuous(limits = c(0, 135)) +
  labs(title = "Booking at Capacity", x = NULL, y = NULL) +
  theme(legend.position = "none")

overbooking + no_overbooking
ggsave(here::here("R","figures", "Figure2.png"), 
       height = 11/3, width = 8.5)













sample_fn_overbook <- function(data_input, p_threash=0.99) {
  # Input data for a single booking date
  success <- FALSE; i <- 1; # Initializing
  samp <- data_input[1,]
  while(!success) {
    samp[i,] <- slice_sample(data_input, n = 1)# select booking at random until
    success <- sum(samp$cap_fra) > p_threash   # expected capacity is reached
    i <- i + 1
  }
  samp <- samp[1:i,]
  # output resampled bookings 
  return(samp)
}
