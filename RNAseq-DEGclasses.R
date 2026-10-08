# Set the working directory
##change this to the location where you saved the reference and data files on your computer  
setwd("~/Desktop/R/any/other/nested/folder/names") #syntax for Mac 
setwd("c:/Documents/my/working/directory") #syntax for Windows

# Load packages. If any are missing, use install.packages('name')
library('ggplot2')
library('ggrepel')
library('ggbreak')
library('dplyr')
library('tidyr')
library('stringr')
library('data.table')
library('ggprism')
library('ggh4x')
library('dplyr')
library('tibble')

#read in reference files
## spu file is old to new genome version gene names
spu <- read.table("~/Desktop/R/CompBio_RNAseq_files/refseqLocus_spu_IDmapping.txt", 
                  sep = "\t", header = TRUE, quote = "") #note: when you're using scripts off GitHub, you'll often need to do some pathway renaming to make sure things match your own computer
head(spu) #use this to look at the top of the dataframe
colnames(spu) <- c("names", "SPU", "sp_name")

## gene ontology file from Tu et al.
onto <- read.csv("~/Desktop/R/CompBio_RNAseq_files/Tu_Ontology_SuppTableS2.csv")

## combine name reference file with gene ontology file. This matches up LOC IDs with SPU IDs.
LOConto <- merge(onto, spu, by = "SPU") 

#read in DEG file - RNAseq analysis results from DESeq2
res <- read.table("low14-24hpi_vs_low14-0hpi.txt") 
head(res)
res <- rownames_to_column(res, var = "names")
res$names <- str_remove(res$names, "gene-") #removing the "gene-" prefix from the names

#Class L1 names  
table(onto$Class.L1)

#Example: looking up differentially expressed genes in an ontological class and plotting the results ----
#Immune class search 
df <- subset(LOConto, Class.L1 == "Immunity") #pick another class from the list above and substitute the name here! This creates a list of genes in a particular class.
dfDEG <- subset(res, names %in% df$names) #pulls out genes from the results file that match the names in the class you chose above
dfDEG <- na.omit(dfDEG) #remove genes that have NA values
dim(dfDEG) #total number of genes in the list
sum(dfDEG$padj <= 0.05 & abs(dfDEG$log2FoldChange) > 0.5) #how many genes are significantly different based on p-adj and log2FoldChange
sum(dfDEG$log2FoldChange > 0.5) #How many genes are upregulated
sum(dfDEG$log2FoldChange < -0.5) #How many genes are downregulated

#Volcano plot visualization of differentail gene expression
## Create column with direction of DE 
dfDEG$DE <- "No change"
dfDEG$DE[dfDEG$log2FoldChange > 0.5 & dfDEG$padj < 0.05] <- "Up"
dfDEG$DE[dfDEG$log2FoldChange < -0.5 & dfDEG$padj < 0.05] <- "Down"

#Create a list of colors and assign a color to each DE 
de_colors <- c("coral2", "#69BE28", "darkgray") #note the different ways to use colors! You can call colors by name or use hexcodes to expand your color palette even further.
names(de_colors) <- c("Up", "Down", "No change") #this assigns a color to the specific DE direction

## Use ggplot to plot the genes according to p-adj and LFC
volcano <- ggplot(data = dfDEG, 
                  aes(x = log2FoldChange, y = -log10(padj), col = DE)) + 
  geom_point(na.rm = TRUE) + 
  scale_color_manual(values = de_colors) + #color code points by DE direction
  geom_vline(xintercept = c(-0.5, 0.5), col = "brown1") + #add vertical lines at p-adj significance cutoff
  geom_hline(yintercept = -log10(0.05), col = "brown1") + #add horizontal lines at LFC significance cutoff
  xlab(expression(bold("log"[2]~Fold~Change))) + 
  ylab(expression(bold("-log"[10]~"Adjusted p-value"))) +
  theme_prism() + #this makes the plot prettier
  theme(axis.text.x = element_text(size = 16), # x-axis numbers size
        axis.title.x = element_text(size = 20), # x-axis title size
        axis.text.y = element_text(size = 16, colour = "black"),  # y-axis numbers size
        axis.title.y = element_text(size = 20),  # y-axis title size
        legend.position = "none", #remove legend
        legend.title = element_blank()) + #remove legend title
  force_panelsizes(rows = unit(5, "in"), #sets height of plot
                   cols = unit(5, "in")) #sets width of plot 
print(volcano) #display plot

# To save as a jpg 
ggsave(plot = volcano, 
       filename = "~/Desktop/R/MammaMia/resWat24-immune-Plot.jpg", 
       scale = 1, width = 6, height = 6, units = c("in"), 
       dpi = 300)

#Another potentially useful code chunk. Adds labels to plot points. 
#This would be added to the ggplot above. Position of labels is specified in the same way 
geom_text_repel(data = dfDEG, 
                aes(x = log2FoldChange, y = -log10(padj), label = names), 
                size = 4, color = "black", max.overlaps = Inf)

#If labeling all points is too many labels for readability, you can label only a subset of points: 
#Example of labeling subset. Numbers will need to be adjusted based on data set. 
subset(dfDEG, ((DE == "Up" | DE == "Down") & (log2FoldChange > 3.5 | -log10(padj) > 8)))
#Note: & is "and" operator (both are true) 
#Note: | is "or" operator


# Other things you can try: 
# Can you find the genes with the greatest change in expression from 0 to 24 hpi?
# Pick another csv file to look at. Compare the results from the same gene class. 
## Note that to do this, you can copy and paste the chunk of script above, but you'll want to change variable names so that you don't undo your work from above by assigning new data sets under those variables!
# Can you figure out how to plot both sets of genes onto the same graph but keeping either colors or shapes of the points distinct so you can still see both results?

