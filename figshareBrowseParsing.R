# This is a slightly more advanced, in-progress workflow that requires a figshare account. 
# You may need base64enc package to easily authenticate, at least for the V1 API using rfigshare.
# When you run fs_ commands that have private workspace defaults, you will be asked to authenticate via your browser.


library(rfigshare)

# Get a list of files in my account (this will include private/draft stuff)
mine <- fs_browse()
str(mine)

# Make a tabular view of all account items
my1 <- unlist(mine)
myT <- cbind(my1)

# This is not immediately useful, but possibly down the line; calculates differences in lengths between each entry
starts <- which(names(my1) == "article_id")
starts <- append(starts, length(my1))

deltas <- diff(starts, lag = 1)
deltas <- append(deltas, 0, after = 0)

# Resume more useful stuff; make a matrix view! of the list, expanded to only one level
mineU1 <- unlist(mine, recursive = FALSE)
mineT1 <- cbind(mineU1)
mineM1 <- matrix(mineT1, nrow = length(mineT1)/length(mine), ncol = length(mine))

rownames(mineM1) <- cbind(unique(rownames(mineT1)))

# Make a copy as a data frame
mineDF1      <- as.data.frame(mineM1)
mineDF1slice <- lapply(mineDF1[11:15, ], function(x) unlist(x))

DF1sliceU <- cbind(unlist(mineDF1slice))
DF1sliceU <- cbind(rownames(DF1sliceU), DF1sliceU)
ss        <- strsplit(DF1sliceU[,1], split = "\\.")

ssU           <- unlist(ss)
ssU           <- matrix(ssU, ncol = 3, byrow = TRUE)
colnames(ssU) <- c("ID", "L1", "L2")

# Get the unique items that can belong to items that are nested lists to understand possible parent-child relationships
fsListItems   <- aggregate(ID ~ L2 + L1, data = ssU, length)
fsListItems   <- fsListItems[, c(2, 1, 3)]


