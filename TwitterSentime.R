install.packages("rtweet")
install.packages("ROAuth")
install.packages("twitteR")
install.packages("syuzhet")
library(syuzhet)
library(twitteR)
library(rtweet)
library(dplyr)
library(tidyr)
library(tidytext)
library(xlsx)
library(wordcloud)
library(ROAuth)
library(tm)
##
tweets_b <- searchTwitter("#BTS", n=100,lang = "en")
tweets_e <- searchTwitter("#EXO", n=100,lang = "en")
tweets_j <- searchTwitter("#JOY", n=100,lang = "en")
tweets_black <- searchTwitter("#BLACKPINK", n=100,lang = "en")

##
bts_tweets <- twListToDF(tweets_b)
xo_tweets <- twListToDF(tweets_e)
joy_tweets <- twListToDF(tweets_j)
blackpink_tweets <- twListToDF(tweets_black)

##
View(bts_tweets)
View(xo_tweets)
View(joy_tweets)
View(blackpink_tweets)

##
bts_tweets<- bts_tweets$text
xo_tweets<- xo_tweets$text
joy_tweets<- joy_tweets$text
blackpink_tweets<- blackpink_tweets$text
##
#convert all text to lower case
bts_tweets<- tolower(bts_tweets)
xo_tweets<- tolower(xo_tweets)
joy_tweets<- tolower(joy_tweets)
blackpink_tweets<- tolower(blackpink_tweets)

# Replace blank space ("rt")
bts_tweets <- gsub("rt", "", bts_tweets)
xo_tweets <- gsub("rt", "", xo_tweets)
joy_tweets <- gsub("rt", "", joy_tweets)
blackpink_tweets <- gsub("rt", "", blackpink_tweets)

# Replace @UserName
bts_tweets <- gsub("@\\w+", "", bts_tweets)
xo_tweets <- gsub("@\\w+", "", xo_tweets)
joy_tweets <- gsub("@\\w+", "", joy_tweets)
blackpink_tweets <- gsub("@\\w+", "", blackpink_tweets)

# Remove punctuation
bts_tweets <- gsub("[[:punct:]]", "", bts_tweets)
xo_tweets <- gsub("[[:punct:]]", "", xo_tweets)
joy_tweets <- gsub("[[:punct:]]", "", joy_tweets)
blackpink_tweets <- gsub("[[:punct:]]", "", blackpink_tweets)


# Remove links
bts_tweets <- gsub("http\\w+", "", bts_tweets)
xo_tweets <- gsub("http\\w+", "", xo_tweets)
joy_tweets <- gsub("http\\w+", "", joy_tweets)
blackpink_tweets <- gsub("http\\w+", "", blackpink_tweets)

# Remove tabs
bts_tweets <- gsub("[ |\t]{2,}", "", bts_tweets)
xo_tweets <- gsub("[ |\t]{2,}", "", xo_tweets)
joy_tweets <- gsub("[ |\t]{2,}", "", joy_tweets)
blackpink_tweets <- gsub("[ |\t]{2,}", "", blackpink_tweets)


# Remove blank spaces at the beginning
bts_tweets <- gsub("^ ", "", bts_tweets)
xo_tweets <- gsub("^ ", "", xo_tweets)
joy_tweets <- gsub("^ ", "", joy_tweets)
blackpink_tweets <- gsub("^ ", "", blackpink_tweets)

# Remove blank spaces at the end
bts_tweets <- gsub(" $", "", bts_tweets)
xo_tweets <- gsub(" $", "", xo_tweets)
joy_tweets <- gsub(" $", "", joy_tweets)
blackpink_tweets <- gsub(" $", "", blackpink_tweets)

#### removes graphic characters  #like emoticons 
bts_tweets=gsub('[^[:graph:]]', ' ',bts_tweets) 
xo_tweets=gsub('[^[:graph:]]', ' ',xo_tweets) ## 
joy_tweets=gsub('[^[:graph:]]', ' ',joy_tweets) # 
blackpink_tweets=gsub('[^[:graph:]]', ' ',blackpink_tweets) #

##Replace emoticon #stringr
bts_tweets=str_replace_all(bts_tweets,"[^[:graph:]]", " ") 
xo_tweets=str_replace_all(xo_tweets,"[^[:graph:]]", " ") 
joy_tweets=str_replace_all(joy_tweets,"[^[:graph:]]", " ") 
blackpink_tweets=str_replace_all(blackpink_tweets,"[^[:graph:]]", " ") 
# removes control characters
bts_tweets = gsub('[[:cntrl:]]', '', bts_tweets) 
xo_tweets = gsub('[[:cntrl:]]', '', xo_tweets) 
joy_tweets = gsub('[[:cntrl:]]', '', joy_tweets) 
blackpink_tweets = gsub('[[:cntrl:]]', '', blackpink_tweets) 






##Change the data into corpus  #VCorpus belongs to tm library
bts_tweets.corpus <- VCorpus(VectorSource(bts_tweets))
xo_tweets.corpus <- VCorpus(VectorSource(xo_tweets))
joy_tweets.corpus <- VCorpus(VectorSource(joy_tweets))
blackpink_tweets.corpus <- VCorpus(VectorSource(blackpink_tweets))

#remove whitespace
bts_tweets.corpus <- tm_map(bts_tweets.corpus, stripWhitespace)
xo_tweets.corpus <- tm_map(xo_tweets.corpus, stripWhitespace)
joy_tweets.corpus <- tm_map(joy_tweets.corpus, stripWhitespace)
blackpink_tweets.corpus <- tm_map(blackpink_tweets.corpus, stripWhitespace)


#clean up by removing stop words
bts_tweets.text.corpus <- tm_map(bts_tweets.corpus, function(x) removeWords(x,stopwords()))
xo_tweets.text.corpus <- tm_map(xo_tweets.corpus, function(x) removeWords(x,stopwords()))
joy_tweets.text.corpus <- tm_map(joy_tweets.corpus, function(x) removeWords(x,stopwords()))
blackpink_tweets.text.corpus <- tm_map(blackpink_tweets.corpus, function(x) removeWords(x,stopwords()))

set.seed(1234) # for reproducibility 
wordcloud(bts_tweets.text.corpus,min.freq = 1,colors=brewer.pal(8, "Dark2"),
          random.color = TRUE,max.words = 100,rot.per = 0.35)

wordcloud(xo_tweets.text.corpus,min.freq = 3,colors=brewer.pal(8, "Dark2"),
          random.color = TRUE,max.words = 100,rot.per=0.35)

wordcloud(joy_tweets.text.corpus,min.freq =1,colors=brewer.pal(8, "Dark2")
          ,random.color = TRUE,max.words = 100,rot.per=0.35)

wordcloud(blackpink_tweets.text.corpus,min.freq = 4,colors=brewer.pal(8, "Dark2"),
          random.color = TRUE,max.words = 100,rot.per = 0.35)


##################################33333333
#getting emotions using in-built function  (syuzhet package)
mysentiment_bts<-get_nrc_sentiment((bts_tweets))
mysentiment_exo<-get_nrc_sentiment((xo_tweets))
mysentiment_joy<-get_nrc_sentiment((joy_tweets))
mysentiment_black<-get_nrc_sentiment((blackpink_tweets))

#
Sentimentscores_bts<-data.frame(colSums(mysentiment_bts[,]))
Sentimentscores_exo<-data.frame(colSums(mysentiment_exo[,]))
Sentimentscores_joy<-data.frame(colSums(mysentiment_joy[,]))
Sentimentscores_black<-data.frame(colSums(mysentiment_black[,]))

names(Sentimentscores_bts)<-"Score"
Sentimentscores_bts<-cbind("sentiment"=rownames(Sentimentscores_bts),Sentimentscores_bts)
rownames(Sentimentscores_bts)<-NULL

names(Sentimentscores_exo)<-"Score"
Sentimentscores_exo<-cbind("sentiment"=rownames(Sentimentscores_exo),Sentimentscores_exo)
rownames(Sentimentscores_exo)<-NULL

names(Sentimentscores_joy)<-"Score"
Sentimentscores_joy<-cbind("sentiment"=rownames(Sentimentscores_joy),Sentimentscores_joy)
rownames(Sentimentscores_joy)<-NULL

names(Sentimentscores_black)<-"Score"
Sentimentscores_black<-cbind("sentiment"=rownames(Sentimentscores_black),Sentimentscores_black)
rownames(Sentimentscores_black)<-NULL


#plotting the sentiments with scores
ggplot(data=Sentimentscores_bts,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on BTS")


ggplot(data=Sentimentscores_exo,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on EXO")


ggplot(data=Sentimentscores_joy,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on JOY")


ggplot(data=Sentimentscores_black,aes(x=sentiment,y=Score))+geom_bar(aes(fill=sentiment),stat = "identity")+
  theme(legend.position="none")+
  xlab("Sentiments")+ylab("scores")+ggtitle("Sentiments of people behind the tweets on BLACKPINK")



