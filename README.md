Twitter Sentiment Analysis using R 

Sentiment Analysis of K-pop Artist (JOY,BTS,EXO and BLACKPINK)

What is Sentimental Analysis ?
 
Sentiment analysis refers to the use of NLP (Natural Language Processing), text analysis and computational linguistics to identify and extract information from the source data.
It is a process to determine the emotion of the writer whether the writing is positive, negative or neutral, in depth other emotions such as fear, anger etc.
 
It is a common use of the technology to determine or discover how people feel about a particular topic.
 
In this topic we have used NRC sentiment dictionary to calculate the presence of 8 emotions corresponding to the text.
 
Why Twitter?
 
Online activity across the globe is increasing rapidly, the volume of the post are increasing in hundreds in milliseconds.
Social Media is a place where people express their interest, share their views, compliment and show some dis-pleasures.
Mostly, companies use this to understand about their customers.
 
Now let’s get started.
 
Twitter Dataset.
 
	- Step 1: 
Authenticate using your credentials to Twitter’s API by creating an access token. Steps on getting Twitter access tokens:
 
https://cran.r-project.org/web/packages/rtweet/vignettes/auth.html
 
Navigate to developer.twitter.com/en/apps and select your Twitter app
Click the tab labeled Keys and tokens to retrieve your keys.
Locate the Consumer API keys (aka “API Secret”).




api_key <- "0ucrEr5IXXXXXXXXXX"
api_secret_key <- "pCkKBIP4CaPaPnNTjLlkXlaxxxxxxxxxxxxxxxxxxx"
access_token <- "910182696541753349-POFccXXXXXXXXXXXXXXXXXXxx"
access_token_secret <- "gam5AMtJb53QOydOsMDYXXXXXXXXXXXXXXXCEm"
my_oauth <- setup_twitter_oauth( api_key, api_secret_key,  access_token,access_token_secret)



	- Step 2:
Load the required packages (including rtweet) in Rstudio




	- Step 3:
Extract tweets using particular hashtag 
searchTwitter -  function is used to issue a search of Twitter based on supplied search string 
	N=  Maximum number of tweets to return 
	Lang = restrict the tweets to the given language



	- Step 4:
Converting the data into daaframe which will more it more easy to read and work with.
twListToDF- function is used to convert list to data frames.
View - Function will invoke a spreadsheet-style data viewer



After viewing the spreadsheet data it will be clear to how to process and remove unnecessary data which will not be required 

	- Step 5:
 
This is pre-process where will remove tabs, blank spaces, links etc. 


	- Step 6:

The Main Structure of managing documents in tm is so-called Corpus, representing a collection of text documents.
Vcorpus is short of Volatile Corpus
 

	- Step 7: 

Remove Stop Words

	- Step 8:

Create WordCloud

	- Step 9:

Sentiment Analysis

The  plot that I have are



