##### Word cloud fun
install.packages("XML")
require(XML)
install.packages("tm")
require(tm)
install.packages("wordcloud")
require(wordcloud)
require(RColorBrewer)


##### Attempting Abel's Example
u = "http://cran.r-project.org/web/packages/available_packages_by_date.html"
t <- readHTMLTable(u)[[1]]
ap.corpus <- Corpus(DataframeSource(data.frame(as.character(t[,3]))))
ap.corpus <- tm_map(ap.corpus, removePunctuation)
ap.corpus <- tm_map(ap.corpus, tolower)
ap.corpus <- tm_map(ap.corpus,function(x)removeWords(x,stopwords("english")))
ap.tdm <- TermDocumentMatrix(ap.corpus) #This part isn't working
# Error: inherits(doc, "TextDocument") is not TRUE

##### Trying my own example using text message data
Lisa <- read.csv("C:/Users/Dan/Google Drive/UCSC/Abel's Data Viz Course/Lisa.csv") #Note: Replace with your own .csv
Jo <- Lisa$message
Jo.corpus <- Corpus(DataframeSource(data.frame(as.character(Jo))))
Jo.corpus <- tm_map(Jo.corpus, removePunctuation)
Jo.corpus <- tm_map(Jo.corpus, content_transformer(tolower))
Jo.corpus <- tm_map(Jo.corpus, removeWords, stopwords("english"))
Jo.tdm <- TermDocumentMatrix(Jo.corpus)
Jo.m <- as.matrix(Jo.tdm)
Jo.v <- sort(rowSums(Jo.m),decreasing=TRUE)
Jo.d <- data.frame(word = names(Jo.v),freq = Jo.v)
table(Jo.d$freq)
pal2 <- brewer.pal(8,"Dark2")
windows(width = 12, height = 12)
jpeg(filename = 'LisaWordCloud.jpg')
wordcloud(Jo.d$word,Jo.d$freq,scale = c(8,.2),min.freq = 3,random.order = FALSE, rot.per = .15, colors = pal2)
dev.off()


##### Another one with Kurtis's data
Kurtis <- read.csv("C:/Users/Dan/Google Drive/UCSC/Abel's Data Viz Course/Kurtis.csv") #Note: Replace with your own .csv
Jo <- Kurtis$message
Jo.corpus <- Corpus(DataframeSource(data.frame(as.character(Jo))))
Jo.corpus <- tm_map(Jo.corpus, removePunctuation)
Jo.corpus <- tm_map(Jo.corpus, content_transformer(tolower))
Jo.corpus <- tm_map(Jo.corpus, removeWords, stopwords("english"))
Jo.tdm <- TermDocumentMatrix(Jo.corpus)
Jo.m <- as.matrix(Jo.tdm)
Jo.v <- sort(rowSums(Jo.m),decreasing=TRUE)
Jo.d <- data.frame(word = names(Jo.v),freq = Jo.v)
table(Jo.d$freq)
pal2 <- brewer.pal(8,"Dark2")
windows(width = 12, height = 12)
jpeg(filename = 'KurtisWordCloud.jpg')
wordcloud(Jo.d$word,Jo.d$freq,scale = c(8,.2),min.freq = 3,random.order = FALSE, rot.per = .15, colors = pal2)
dev.off()