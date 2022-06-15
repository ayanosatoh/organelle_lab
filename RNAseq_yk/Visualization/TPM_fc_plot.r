library(tidyverse)

in_f2A <- "data/OS_glyco_gene_all.csv"
in_f2B <- "data/SFN_1_OS_Glycan.csv"

f2A <- read_csv(in_f2A)
f2B <- read_csv(in_f2B)

gene_levels = c("ATRN","FUT8","GBA","HYAL1","HYAL2","MBL2","MGAT3",
                "PKD2","PLA2R1","PRKAA2","PRNP","SDC1","SMPD3",
                "SPHK1", "VNN1")

# y-axis limit
y_max = 1.5
y_min = -1.5

# fig2A(5H4PB)
# f2A_fclog2 <- f2A %>% 
#   select(product,`8`,`9`,`10`,`11`,`12`) %>%
#   rowwise() %>%
#   mutate(control = mean(c(`8`,`9`)),
#          treat = mean(c(`10`,`11`,`12`))) %>% 
#   mutate(log2 =log2((treat+10^-12)/(control+10^-12))) %>%
#   rownames_to_column() %>%
#   mutate(colour = factor(rowname, levels =seq(1,15))) %>%
#   mutate(product = factor(product, levels=gene_levels))

f2A_fc <- f2A %>%
  rownames_to_column() %>%
  mutate(colour = factor(rowname, levels =seq(1,15))) %>%
  mutate(product = factor(product, levels=gene_levels)) %>%
  mutate(value = if_else(`log2(10-12ave/8-9ave)`> y_max, y_max+0.2,
                         if_else(`log2(10-12ave/8-9ave)`< y_min, y_min-0.2,
                                 `log2(10-12ave/8-9ave)`))) 

# plot
png(filename = "figure/fig2A_5h4pb.png",
    height = 4*300, width = 7*300, res=300 )  

ggplot(f2A_fc, aes(x = product, y = value,fill = colour)) +
# ggplot(f2A_fclog2, aes(x = product, y = log2,fill = colour)) +
  geom_bar(stat = "identity") +
  coord_flip()+
  scale_x_discrete(limits=rev(levels(f2A_fclog2$product))) +
  scale_y_continuous(expand = c(0,0),
                     limits = c(A_min-0.2, A_max+0.2),
                     breaks = seq(A_min, A_max, 0.5))+
  xlab("Gene Symbols") +
  ylab("log2(5H4PB treated TPM/Control TPM)") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.title.x = (element_text(size = 14)),
        axis.text.x = (element_text(size = 14)),
        axis.title.y = (element_text(size = 14)),
        axis.text.y = (element_text(size = 10))) +
  guides(fill =　"none") +
  scale_fill_hue(l = 70,c = 55)

dev.off()

# fig2B(HaCaT)

f2B_fclog2 <- f2B %>%
  select(product,HaCaT_SFN,HaCaT_Cont) %>%
  mutate(fclog2 =log2((HaCaT_SFN+0.01)/(HaCaT_Cont+0.01))) %>%
  rownames_to_column() %>%
  mutate(colour = factor(rowname, levels =seq(1,15))) %>%
  mutate(product = factor(product, levels=gene_levels))%>%
  mutate(value = if_else(fclog2 > y_max, y_max+0.2,
                         if_else(fclog2< y_min, y_min-0.2,
                                 fclog2))) 
# plot
png(filename = "figure/fig2B_hacat.png",
    height = 4*300, width = 7*300, res=300 )  

ggplot(f2B_fclog2, aes(x = product, y = value,fill = colour)) +
  geom_bar(stat = "identity") +
  coord_flip()+
  scale_x_discrete(limits=rev(levels(f2B_fclog2$product))) +
  scale_y_continuous(expand = c(0,0),
                     limits = c(y_min-0.2, y_max+0.2),
                     breaks = seq(y_min, y_max, 0.5))+
  xlab("Gene Symbols") +
  ylab("log2(SFN treated TPM/Control TPM)") +
  theme_bw() +
  theme(panel.grid = element_blank(),
        axis.title.x = (element_text(size = 14)),
        axis.text.x = (element_text(size = 14)),
        axis.title.y = (element_text(size = 14)),
        axis.text.y = (element_text(size = 10))) +
  guides(fill =  "none") +
  scale_fill_hue(l = 70,c = 55)　

dev.off()
