library(tidyverse)
library(hrbrthemes)
library(viridis)
library(plotly)
library(d3heatmap)
library(htmlwidgets)

data <- read.table("processed_data.csv", header=T, sep=",")
colnames(data) <- gsub("\\.", " ", colnames(data))

data <- data %>% 
  arrange(Área) %>%
  mutate(Área = factor(Área, Área))

mat <- data
rownames(mat) <- mat[,1]
mat <- mat %>% dplyr::select(-Área)
mat <- as.matrix(mat)

library(heatmaply)
p <- heatmaply(mat, 
               margins = c(60,100,40,20),
               grid_color = "white",
               grid_width = 0.00001,
               branches_lwd = 0.1,
               label_names = c("Área", "Faixa", "Reclamações"),
               labCol = colnames(mat),
               labRow = rownames(mat),
               xlab = "Faixas Etárias",
               ylab = "Áreas",
               main = "Heatmap - Áreas das reclamações por faixa etárias",
               key.title = "Reclamações",
               heatmap_layers = theme(axis.line=element_blank())
)

saveWidget(p, file= "heatmap.html")