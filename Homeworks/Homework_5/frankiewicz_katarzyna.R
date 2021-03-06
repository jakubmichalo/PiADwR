library(ggplot2)
library(data.table)
library(microbenchmark)
library(tibble)
library(tidyverse)



my_data = data.frame(expr = 0, time = 0, i = 0)
i = 0

N <- c(100, 10^4, 10^6)
G <- c(10, 20)

for (n in N){
  
  for (g in G){
    
    i = i + 1
    dt <- data.table( X = sample(x = letters[1:G], replace = TRUE, size = N),
                      Y = sample(1:N, N),
                      W = sample(1:N, N),
                      Z =  sample(1:N, N))
    
    df <- as.data.frame(dt)
    t <- as_tibble(dt)
    
    f_micro <- microbenchmark(Dt = dt[, sum(Y + W + Z), by = c("X")],
                              Df = aggregate(Y + W + Z ~ X, data = df, FUN = sum),
                              Tv = ft <- t %>%
                                group_by(X) %>%
                                summarize(sum(Y + W + Z)),
                times = 10)
    
    f_micro <- cbind(f_micro, i = i)
    my_data <- rbind(my_data, f_micro)
    
  }
  
}   

my_data <- my_data[-1,]
#my_data
ggplot(my_data)+
  geom_boxplot(aes(x = expr, y = time))+
  facet_wrap(~i, scales = "free")+
  theme_bw()
    