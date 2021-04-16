# annotation_related
short scripts related with annotation, alignments, etc
1. create 3'UTR for all mf5 genes with NCBI refseq annotation downloaded from UCSC (?)


# convert NCBI accession number to chromosome number 
```
library(readr)
library(tidyverse)
GCF_000364345_1_Macaca_fascicularis_5_0_assembly_report <- read_delim("~/projects/rnaseq/mouse_studies/20-RES-077/data/mod_GCF_000364345.1_Macaca_fascicularis_5.0_assembly_report.txt", 
                                                                      "\t", escape_double = FALSE, col_types = cols(`Sequence-Name` = col_character(), 
                                                                                                                    `Sequence-Role` = col_character()), 
                                                                      comment = "#", trim_ws = TRUE)
GCF_000364345_1_Macaca_fascicularis_5_0_assembly_report %>% 
  select(`RefSeq-Accn`, `Assigned-Molecule`) -> mf5_NCBI2Ensembl

#%>%
#  mutate(`Assigned-Molecule` = ifelse(`Assigned-Molecule`=="na", "", `Assigned-Molecule`))-> mf5_NCBI2Ensembl

# %>%
#filter(`Assigned-Molecule` != "na") 
write_tsv(mf5_NCBI2Ensembl, "../data/mf5_NCBI2Ensembl.txt", col_names = F, eol = "\n")

# https://github.com/dpryan79/ChromosomeMappings
inputGTF="GCF_000364345.1_Macaca_fascicularis_5.0_genomic.gtf.gz"
outputGTF="Macaca_fascicularis_5.0_genomic.Refseq_v101.gtf.gz"
match="mf5_NCBI2Ensembl.txt"
cvbio UpdateContigNames \
-i $inputGTF \
-o $outputGTF \
-m $match \
--comment-chars '#' \
--columns 0 \
--skip-missing false


GTF="/data/genomics/Jun/references/NCBI.Macaca_facicularis_release_101/Macaca_fascicularis_5.0_genomic.Refseq_v101.gtf.gz"


```
