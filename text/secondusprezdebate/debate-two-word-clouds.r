#load libraries
library(qdap)
library(wordcloud)
library(tm)
library(RColorBrewer)
library(SnowballC)

#load csv files by speaker
clinton <- read.csv("~/r_projects/HC.csv")
trump <- read.csv("~/r_projects/DT.csv")

#isolate TEXT column
clinton_text <- clinton$TEXT
trump_text <- trump$TEXT

#Create Clinton corpus, convert to lower to prep removal of stopwords, remove punctuation, convert to plain-text
clintonCorpus <- Corpus(VectorSource(clinton_text))
clintonCorpus <- tm_map(clintonCorpus, PlainTextDocument)
clintonCorpus <- tm_map(clintonCorpus, tolower)
clintonCorpus <- tm_map(clintonCorpus, removeWords, stopwords("english"))
clintonCorpus <- tm_map(clintonCorpus, removePunctuation)
clintonCorpus <- tm_map(clintonCorpus, PlainTextDocument)

#Create word cloud from clintonCorpus, use all remaining words that occur more than three times, where bigger words are more frequent
ap.tdm <- TermDocumentMatrix(clintonCorpus)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("clinton-debate-two-word-cloud.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3, max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()

#Create Trump corpus, convert to lower to prep removal of stopwords, remove punctuation, convert to plain-text
trumpCorpus <- Corpus(VectorSource(trump_text))
trumpCorpus <- tm_map(trumpCorpus, PlainTextDocument)
trumpCorpus <- tm_map(trumpCorpus, tolower)
trumpCorpus <- tm_map(trumpCorpus, removeWords, stopwords("english"))
trumpCorpus <- tm_map(trumpCorpus, removePunctuation)
trumpCorpus <- tm_map(trumpCorpus, PlainTextDocument)

#Create word cloud from trumpCorpus, use all remaining words that occur more than three times, where bigger words are more frequent
ap.tdm <- TermDocumentMatrix(trumpCorpus)
ap.m <- as.matrix(ap.tdm)
ap.v <- sort(rowSums(ap.m),decreasing=TRUE)
ap.d <- data.frame(word = names(ap.v),freq=ap.v)
table(ap.d$freq)
pal2 <- brewer.pal(8,"Dark2")
png("trump-debate-two-word-cloud.png", width=1280,height=800)
wordcloud(ap.d$word,ap.d$freq, scale=c(8,.2),min.freq=3, max.words=Inf, random.order=FALSE, rot.per=.15, colors=pal2)
dev.off()
