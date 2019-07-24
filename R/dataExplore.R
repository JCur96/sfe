# dataExplore <- function(x) {
#   p <- ggplot(NHM_Pangolins, aes(x=binomial, y=binomial_overlap)) +
#     geom_boxplot() +
#     scale_x_discrete(labels = abbreviate)
#   p
#   p2 <- ggplot(NHM_Pangolins, aes(x=Decade, y=binomial_overlap)) +
#     geom_point()
#   p2
#   p3 <- ggplot(NHM_Pangolins, aes(x=binomial, y=distance)) +
#     geom_boxplot() +
#     scale_x_discrete(labels = abbreviate)
#   p3
#   p4 <- ggplot(NHM_Pangolins, aes(x=Decade, y=distance)) +
#     geom_point()
#   p4
#   plots <- gridExtra::grid.arrange(p, p2, p3, p4, ncol=2)
#   return(plots)
# }
# dataExplore(NHM_Pangolins)
