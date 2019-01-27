# textmining_lyricbased_2018
In this repository I would like to share my experiments during my study with aims to present a novel approach of exploring lyrics to classify and analyse lyrics, experimenting with n-gram and more sophisticated features that can be find in text such as vocabulary, length of sentence, song structure, topic modelling and sentiment analysis.
The study was started with the hypotheses that lyric can be trained to classify music genre with the help of Support Vector Machine (SVM). Beside all other interesting features, some interesting facts about lyrics insight were also found during the exploration such as top 100 words per song and average music character per genre. 
The findings lead to the conclusion that SVM are potentially useful to do the genre classification task. 
To be more convincing that SVM can run the classification task well, a survey to define music genre manually by human was made. 
Later on, I compared the accuracy of genre classification between SVM and human. 

This github consist of 5 R file, which is:
1. Tf-Idf file -> About how to get the Tf-Idf value. How to classify genre based on lyrics Tf-Idf sroce
2. Lexical Analysis -> How to calculate unique words and lexical density
3. Length -> How to calculate how many word and etc
4. LDA -> Genre clusterin
5. Sentiment Analysis -> To get the sentiment per genre

Point 1, 2, 3 were calculated by SVm (Support Vector machine).

