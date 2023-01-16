library(tidyverse)

accuracies_df = readxl::read_excel("accuracies.xlsx", col_names = TRUE)

accuracies_df = accuracies_df %>%
  mutate(model = fct_relevel(model,
                             "SVM", "SVM + wagi", "CNN + 50 epok",
                             "CNN + 9 epok", "CNN + 7 epok"))

png("plots/accuracies.png", 800, 600)
ggplot(accuracies_df, aes(x = model, y = accuracy, fill = accuracy)) +
  geom_bar(stat = "identity", width = 0.65) +
  ylim(0, 100) +
  ggtitle("Dokładność modelu") +
  geom_text(aes(label = accuracy), size = 8, vjust = -0.5) +
  theme_bw() +
  theme(title = element_text(size=20),
        axis.text = element_text(size=20),
        axis.text.x = element_text(vjust = 0.75, angle = 15),
        axis.text.y = element_blank(),
        axis.title = element_blank(),
        legend.position = 'none') +
  scale_fill_distiller(palette = "Blues", direction = 1)
dev.off()
