
library(dplyr)
library(tidytext)
library(stringr)

library(gutenbergr)
library(janeaustenr)
library(ggplot2)

hgwells <- gutenberg_download(c(35, 36, 5230, 159))
tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)
tidy_hgwells %>%
  count(word, sort = TRUE)


-------

original_books <- austen_books() %>%
  group_by(book) %>%
  mutate(linenumber = row_number(),
         #cumsum() Returns a vector whose elements are the cumulative sums, products, minima or maxima of the elements of the argument.
         chapter = cumsum(str_detect(text, regex("^chapter [\\divxlc]",
                                                 ignore_case = TRUE)))) %>%
  ungroup()
original_books$text


library(ggplot2)
library(tidytext)
tidy_books <- original_books %>%
unnest_tokens(word, text)


#delete stop words
data(stop_words)
tidy_books <- tidy_books %>%
  anti_join(stop_words)

tidy_books %>%
  count(word, sort = TRUE)

#to display the most repeated words with ggplots

tidy_books %>%
  count(word, sort = TRUE) %>%
  filter(n > 600) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(aes(word, n)) +
  geom_col() +
  xlab(NULL) +
  coord_flip()

#count() is one of function in dplyr package
#Project Gutenberg
library(gutenbergr)
hgwells <- gutenberg_download(c(35, 36, 5230, 159))
tidy_hgwells <- hgwells %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)
tidy_hgwells %>%
  count(word, sort = TRUE)

#bronte
bronte <- gutenberg_download(c(1260, 768, 969, 9182, 767))
tidy_bronte <- bronte %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words)


#calculate the frequency for each word in the works of Jane Austen, 
#the Brontë sisters, and H.G. Wells by binding the data frames together.
library(tidyr)
frequency <- bind_rows(mutate(tidy_bronte, author = "Brontë Sisters"),
                       mutate(tidy_hgwells, author = "H.G. Wells"),
                       mutate(tidy_books, author = "Jane Austen")) %>%
  mutate(word = str_extract(word, "[a-z']+")) %>%
  count(author, word) %>%
  group_by(author) %>%
  mutate(proportion = n / sum(n)) %>%
  select(-n) %>%
  spread(author, proportion) %>%
  gather(author, proportion, `Brontë Sisters`:`H.G. Wells`)

#visualize it
library(scales)
# expect a warning about rows with missing values being removed
ggplot(frequency, aes(x = proportion, y = `Jane Austen`,
                      color = abs(`Jane Austen` - proportion))) +
  geom_abline(color = "gray40", lty = 2) +
  geom_jitter(alpha = 0.1, size = 2.5, width = 0.3, height = 0.3) +
  geom_text(aes(label = word), check_overlap = TRUE, vjust = 1.5) +
  scale_x_log10(labels = percent_format()) +
  scale_y_log10(labels = percent_format()) +
  scale_color_gradient(limits = c(0, 0.001),
                       low = "darkslategray4", high = "gray75") +
  facet_wrap(~author, ncol = 3) +
  theme(legend.position="none") +
  labs(y = "Jane Austen", x = NULL)

#tf-idf
library(dplyr)
library(janeaustenr)
library(tidytext)
austen_books()

book_words <- austen_books() %>%
  unnest_tokens(word, text) %>%
  count(book, word, sort = TRUE) %>%
  ungroup()
total_words <- book_words %>%
  group_by(book) %>%
  summarize(total = sum(n))
book_words <- left_join(book_words, total_words)

str(book_words)
#tf-idf
book_words <- book_words %>%
  bind_tf_idf(word, book, n)
book_words

#Let's look at terms with high tf-idf in Jane Austen's works.
book_words %>%
  select(-total) %>%
  arrange(desc(tf_idf))

split <- round(nrow(book_words) * .80)
train <- book_words[1:split, ]
test <- book_words[(split + 1):nrow(book_words), ]
train <- save.image(file="temp.RData")
rm(list=ls())
load(file="temp.RData")


#prepare the training 
memory.limit()
memory.limit(size=4000)


# defrag memory 
save.image(file="temp.RData")
rm(list=ls())
load(file="temp.RData")



library(e1071)
dat = data.frame(train)
gc()
(l <- sapply(dat, function(x) is.factor(x)))
str(dat)
svmfit = svm(book ~ ., data = dat, kernel = "linear", cost = 10, scale = TRUE)

print(svmfit)





