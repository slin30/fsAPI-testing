# This is a simple first script that does not require authentication.
# Here, we use the V1 API via rfigshare to pull all the available metadata for a public test deposit.
# Some useful takeaways include the nested list structure of certain metadata items that require some workarounds to
#  readily parse

library(rfigshare)

# figshare item details parsing -------------------------------------------
# ID 123 is a test file that usefully demonstrates what the API can provide.
openTest <- fs_details(123)

# Unlist the details one level only
lvl1.unlist <- unlist(openTest, recursive = FALSE)
lvl1.cbind  <- cbind(Data = lvl1.unlist)

# Nesting seems to start with rowname called "authors" so find it
cutPoint <- which(rownames(lvl1.cbind) == "authors")

# subset rows of lvl1.cbind into 2 sections; before and after cutPoint
bottom.section <- lvl1.cbind[cutPoint:length(lvl1.cbind), , drop = FALSE]
top.section    <- lvl1.cbind[1:cutPoint - 1, , drop = FALSE]

# unlist bottom.section one more time
bottom.section <- unlist(bottom.section, recursive = FALSE)

# cbind both sections
t.section <- cbind(Data = top.section)
b.section <- cbind(Data = bottom.section)

# rbind both sections
Output.Matrix <- rbind(t.section, b.section)

# write a text file, as csv
# dir.create("./Outputs")  # Unnecessary but harmless if dir exists; uncomment and run if not
write.csv(Output.Matrix, "./Outputs/OpenTestID123.txt")
