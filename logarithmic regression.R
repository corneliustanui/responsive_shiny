library(ggplot2)
library(plotly)
library(gapminder)
library(tidymodels)
library(vip)
library(ggpmisc)

p <- gapminder %>%
  filter(year==1977) %>%
  ggplot( aes(x = gdpPercap, 
              y = lifeExp, 
              size = pop, 
              color = continent)) +
  geom_point() +
  geom_jitter() + 
  geom_smooth(method = "lm",
              formula = y ~ log(x),
              color = "red",
              se = FALSE)+
  labs(title = "Life Expectancy vs GDP Per Capita",
       y = "Life Expectancy",
       x = "GDP Per Capita")+
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = c(0.88, 0.4),
        legend.title = element_blank(),
        legend.background = element_blank())

p

ggsave(filename = "Life Expectancy vs GDP Per Capita.png",
       width = 7, height = 7,
       units = "in")

ggplotly(p)


# ii) set the default engine
lm_model <- linear_reg() %>% 
  set_engine('lm') %>% # adds lm implementation of linear regression
  set_mode('regression')

lm_model

# Vfit model
data <- gapminder %>%
  filter(year==1977)


lm_fit <- lm_model %>% 
  fit(lifeExp ~ gdpPercap + pop + continent, data = data)

# View lm_fit properties
tidy(lm_fit, exponentiate = TRUE) %>%
  filter(p.value < 0.05)

glance(lm_fit) 
vip(lm_fit)
