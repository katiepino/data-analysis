#load libraries
library(qdap)
library(wordcloud)
library(tm)
library(SnowballC)

#load csv files by speaker
holt <- read.csv("./holt.csv")
clinton <- read.csv("./clinton.csv")
trump <- read.csv("./trump.csv")

#isolate TEXT column
holt_text <- holt$TEXT
clinton_text <- clinton$TEXT
trump_text <- trump$TEXT

#for all speakers: create a corpus, convert to plain text, remove punctuation, remove stopwords, perform stemming
holtCorpus <- Corpus(VectorSource(holt_text))
holtCorpus <- tm_map(holtCorpus, PlainTextDocument)
holtCorpus <- tm_map(holtCorpus, removePunctuation)
holtCorpus <- tm_map(holtCorpus, removeWords, stopwords('english'))
holtCorpus <- tm_map(holtCorpus, stemDocument)

clintonCorpus <- Corpus(VectorSource(clinton_text))
clintonCorpus <- tm_map(clintonCorpus, PlainTextDocument)
clintonCorpus <- tm_map(clintonCorpus, removePunctuation)
clintonCorpus <- tm_map(clintonCorpus, removeWords, stopwords('english'))
clintonCorpus <- tm_map(clintonCorpus, stemDocument)

trumpCorpus <- Corpus(VectorSource(trump_text))
trumpCorpus <- tm_map(trumpCorpus, PlainTextDocument)
trumpCorpus <- tm_map(trumpCorpus, removePunctuation)
trumpCorpus <- tm_map(trumpCorpus, removeWords, stopwords('english'))
trumpCorpus <- tm_map(trumpCorpus, stemDocument)

#plot wordcloud for each speaker
wordcloud(holtCorpus, max.words = 100, random.order = FALSE)
wordcloud(clintonCorpus, max.words = 100, random.order = FALSE)
wordcloud(trumpCorpus, max.words = 100, random.order = FALSE)
