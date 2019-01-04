
# adjust this path to suit you!
# 
setwd("E:/work/Lyrics")

library(readxl)  # to read Excel files

# the file "lyrics-small.xlsx" is in the current working directory
# check with list.files()
lyr = read_excel('lyrics-small.xlsx')
View(lyr)
class(lyr)  # it's a tibble (tbl_df)
names(lyr)

lyr$lyrics

lyr$lyrics[1]  # "Oh baby, how you doing?\r\n


# count the number of lines in each lyric:
# lines are separated by the "\r\n" character
library(stringr)

# get the 50 lines for the first lyric...
lyr.vec = unlist(str_split(lyr$lyrics[1], "\r\n"))  
lyr.vec  # see the 50 lines in the first lyric
length(lyr.vec)  # just count the number of lines in the first lyric (50) 


# now to count the number of words (tokens) in each line of a lyric:
# words are separated by a space (" ")
words = function(s) {
  toks = str_split(s, " ")
  length(unlist(toks))
}

num.words = sapply(lyr.vec, words, USE.NAMES=F)
num.words  # the number of words in each line




