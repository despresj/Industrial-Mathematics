library(tidyverse)
library(patchwork)
library(lubridate)
library(extrafont)
theme_set(theme_light())
source(here::here("R", "capacity_frac.R"))


figure1 <- tibble(p = seq(from = 0.001, to = 1, by = 0.001)) %>% 
  mutate(bookings = map_dbl(p, capacity_frac, 100, 4, 0.0001)) %>% 
  ggplot(aes(x = p, 
             y = bookings, 
             color = bookings > 240, 
             linetype = bookings > 240)) + 
  geom_line() + 
  scale_x_reverse(breaks = c(1, 0.75, 0.5, 0.3, 0.25, 0)) + 
  scale_y_log10(labels=scales::comma_format(), limits = c(100, 1e5),
                breaks = c(100, 240, 1e3, 1e4, 1e5)) + 
  labs(title = "Number of Bookings to Accept if a Hotel has 100 Rooms",
       y = "Estimated Number of Bookings to Make",
       x = "Probability of a Guest's Arrival",
       color =  NULL, 
       linetype = NULL) +
  annotate("text", family="Arial",
           x = 0.6, y = 1.2e4, 
           label = "As the probability of a guest arriving approaches 0\npredicted number of bookings goes to infinity") +
  annotate("segment", 
           x = 0.3, xend = 0.05, 
           y = 1e4, yend = 1e4, 
           colour = "black", size=0.5, alpha=1, 
           arrow=arrow(type = "closed", length = unit(0.02, "npc"))) +
  annotate("text", family="Arial",
           x = 0.65, y = 5e2, 
           label = "Avoid catastrophic losses by restricting the \nbookings to 2.4 times capacity") + 
  annotate("point", 
           x = 0.3,
           y = 240,
           colour = "red", size=2, alpha=0.8) + 
  scale_linetype_manual(values=c("solid", "twodash"))+
  scale_color_manual(values=c('black','red')) + 
  theme(legend.position="none") + 
  theme(text=element_text(family="Arial", size=9)) 

figure1

ggsave(here::here("R","figures", "Figure1.png"), 
       height = 11/3, width = 8.5) # 1/3 of a page


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