make_barchart_race <- function(data,x,y,
                               number=10,
                               title="",
                               caption=""){
  #set up variables for use with tidy evaluation
  y <- rlang::enquo(y)
  x <- rlang::enquo(x)
  number <- rlang::enquo(number)
  
  #take the input dataset, compute ranks within each time period
  data %>%
    group_by(year) %>%
    arrange(-!!y) %>%
    mutate(rank=row_number()) %>%
    #filter to top "number"
    filter(rank<=!!number) -> data
  
  #plot the data
  data %>%
    ggplot(aes(x=-rank,y=!!y,fill=!!x, group=!!x)) +
    geom_tile(aes(y=!!y/2,height=!!y),width=0.9,show.legend = F)+
    geom_text(aes(label=!!x),
              hjust="right",
              colour="black",
              fontface="bold",
              nudge_y=-1000)+
    geom_text(aes(label=scales::comma(!!y)),
              hjust="left",
              nudge_y=2000,
              colour="grey30")+
    theme_minimal() +
    coord_flip(clip="off") +
    scale_x_discrete("") +
    scale_y_continuous("",labels=scales::comma)+
    theme(panel.grid.major.y=element_blank(),
          panel.grid.minor.x=element_blank(),
          plot.title= element_text(size=20,colour="grey50",face="bold"),
          plot.caption = element_text(colour="grey50"),
          plot.subtitle = element_text(size=20,colour="grey50",face="bold"),
          plot.margin = margin(1,1,1,2,"cm"),
          axis.text.y=element_blank())+
    #this bit does the animation by year
    transition_time(year) +
    labs(title=title,
         subtitle='{round(frame_time,0)}',
         caption=caption)-> p
  return(p)
}
#call the function to make the animation:
g<-make_barchart_race(data = data,
                      name,
                      number = value,
                      title="Interbrand Top Global Brands\n(brand values in $)",
                      caption="Source: Interbrand")

animate(g, nframes = 300, fps = 5, end_pause = 20,renderer=gifski_renderer("test.gif"))