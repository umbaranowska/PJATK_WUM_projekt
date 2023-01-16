library(tidyverse)
library(magrittr)

svm = readxl::read_excel("confusion_matrix_to_heatmap.xlsx", col_names = TRUE, sheet = "svm")

svm = svm %>%
  mutate(predicted = fct_relevel(predicted,
                                 "oponiak", "glejak", "guz przysadki"),
         actual = fct_relevel(actual,
                                 "guz przysadki", "glejak", "oponiak"))

png('plots/cm_svm.png', 800, 600)
ggplot(svm, aes(x = predicted, y = actual, fill = n)) +
  geom_tile() +
  ggtitle("Macierz pomyłek - SVM") +
  xlab('Przypisana kategoria') +
  ylab('Prawdziwa kategoria') +
  geom_text(aes(label = n), color = 'white', size = 12) +
  theme_bw() +
  theme(title = element_text(size=30),
        axis.text = element_text(size=30),
        axis.text.x = element_text(vjust = 0.75, angle = 15),
        axis.text.y = element_text(angle = 15),
        axis.title = element_text(size=30),
        legend.position = 'none') +
  scale_fill_distiller(palette = "Blues", direction = 1)
dev.off()




svm_weighted = readxl::read_excel("confusion_matrix_to_heatmap.xlsx", col_names = TRUE, sheet = "svm_weighted")

svm_weighted = svm_weighted %>%
  mutate(predicted = fct_relevel(predicted,
                                 "oponiak", "glejak", "guz przysadki"),
         actual = fct_relevel(actual,
                              "guz przysadki", "glejak", "oponiak"))

png('plots/cm_svm_weighted.png', 800, 600)
ggplot(svm_weighted, aes(x = predicted, y = actual, fill = n)) +
  geom_tile() +
  ggtitle("Macierz pomyłek - SVM + wagi") +
  xlab('Przypisana kategoria') +
  ylab('Prawdziwa kategoria') +
  geom_text(aes(label = n), color = 'white', size = 12) +
  theme_bw() +
  theme(title = element_text(size=30),
        axis.text = element_text(size=30),
        axis.text.x = element_text(vjust = 0.75, angle = 15),
        axis.text.y = element_text(angle = 15),
        axis.title = element_text(size=30),
        legend.position = 'none') +
  scale_fill_distiller(palette = "Blues", direction = 1)
dev.off()




model6 = readxl::read_excel("confusion_matrix_to_heatmap.xlsx", col_names = TRUE, sheet = "model6")

model6 = model6 %>%
  mutate(predicted = fct_relevel(predicted,
                                 "oponiak", "glejak", "guz przysadki"),
         actual = fct_relevel(actual,
                              "guz przysadki", "glejak", "oponiak"))

png('plots/cm_model6.png', 800, 600)
ggplot(model6, aes(x = predicted, y = actual, fill = n)) +
  geom_tile() +
  ggtitle("Macierz pomyłek - sieć konwolucyjna") +
  xlab('Przypisana kategoria') +
  ylab('Prawdziwa kategoria') +
  geom_text(aes(label = n), color = 'white', size = 12) +
  theme_bw() +
  theme(title = element_text(size=28),
        axis.text = element_text(size=30),
        axis.text.x = element_text(vjust = 0.75, angle = 15),
        axis.text.y = element_text(angle = 15),
        axis.title = element_text(size=30),
        legend.position = 'none') +
  scale_fill_distiller(palette = "Blues", direction = 1)
dev.off()
