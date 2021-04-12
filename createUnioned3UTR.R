library(GenomicFeatures)
library(AnnotationHub)
#### library(BSgenome.Mfascicularis.NCBI.5.0) Don't use this, terrible


## build myself
library(BSgenome)
forgeBSgenomeDataPkg("BSgenome.Mfascicularis.UCSC.macFas5-seed")
# $R CMD build BSgenome.Mfascicularis.UCS
# $R CMD check BSgenome.Mfascicularis.UCSC.macFas5_1.0.0.tar.gz
# $install.packages("~/projects/annotation/R/BSgenome.Mfascicularis.UCSC.macFas5_1.0.0.tar.gz", repos = NULL, type = "source")
library(BSgenome.Mfascicularis.UCSC.macFas5)


macFas5.ncbiRefSeq_txdb <- makeTxDbFromGFF("D:/dicerna/annotations/monkey/macFas5.ncbiRefSeq.gtf.gz")
saveDb(macFas5.ncbiRefSeq_txdb, file="D:/dicerna/annotations/monkey/macFas5.ncbiRefSeq.sqlite")


# txdb <- loadDb("D:/dicerna/annotations/monkey/macFas5.ncbiRefSeq.sqlite")



ncbiRefseq.gtf = import("D:/dicerna/annotations/monkey/macFas5.ncbiRefSeq.gtf.gz")
ncbiRefseq.3utr = ncbiRefseq.gtf[ncbiRefseq.gtf$type == "3UTR",]
ncbiRefseq.3utr_by_gene_grl <- split(ncbiRefseq.3utr, ncbiRefseq.3utr$gene_name)
reduced_ncbiRefseq.3utr_by_gene_grl = reduce(ncbiRefseq.3utr_by_gene_grl)
seq_3utr = getSeq(Mfascicularis, reduced_ncbiRefseq.3utr_by_gene_grl)
seq_3utr_c = lapply(seq_3utr, function(x) do.call(c, x))
writeXStringSet(DNAStringSet(seq_3utr_c), "mf5_refseq_3utr.fasta")

sessionInfo()
