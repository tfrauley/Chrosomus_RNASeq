## DESEQ2 Workflow

##Step 1.1 install DeSeq2
if (!require("BiocManager", quietly = TRUE))
  install.packages("BiocManager")
BiocManager::install("DESeq2")

##Step 1.2 Load in count matrix (*change path name*)
Ceos_countmatrix <- read.delim("~/Desktop/Mandeville_Thesis/htseq_data/Ceos_countmatrix", row.names=1) 
View(Ceos_countmatrix)

##Step 1.3 Load in metadata table (*change path name*)
Meta <- read.csv("~/Desktop/Mandeville_Thesis/htseq_data/Meta.csv", row.names=1)
View(Meta)

## Step 1.4 Make DE seq object (*change design based on own metadata*)
dds<- DESeqDataSetFromMatrix(countData = Ceos_countmatrix, colData = Meta, design = ~ Tissue_Type + Individual)

## Step 1.5 do DESeq command
dds <- DESeq(dds)

## Step 1.6 Examine dispersion estimates
plotDispEsts(dds)

##DATA VISUALIZATION

## Step 2.1 convert dds to rlog (for data visualization purposes)
rld <- rlog(dds, blind = TRUE)

## Plot 1: PCA (*change intgroup base*)
plotPCA(rld, intgroup="Tissue_Type")
plotPCA(rld, intgroup="Individual")

## Plot 2: Heatmap
install.packages("pheatmap")
rld_mat <- assay(rld)
rld_cor <- cor(rld_mat)
head(rld_cor)
pheatmap(rld_cor)

## Plot 3: MA (*for individual comparison*)
contrast_indiv <- c("Individual", "Thirteen", "Fourteen")
restable_indiv_unshrunken <- results(dds, contrast = contrast_indiv, alpha = 0.05 )
restable_indiv <- lfcShrink(dds, contrast = contrast_indiv, res = restable_indiv_unshrunken, type="ashr")
plotMA(restable_indiv, ylim=c(-2,2))

  