### USING CSI-UTR
This document illustrates the usage of CSI-UTR using two separate examples, one from a human RNA-Seq dataset studying late onset Alzheimer’s Disease [1], and the second from a mouse RNA-Seq dataset studying optic nerve crush-induced axonal injury [2].  Both of these examples have been examined in detail in the manuscript “Untranslated Regions using CSI-UTR Reveals Regulated Interaction Motifs” (under review) [3].  
### INSTALLING CSI-UTR
Before proceeding with the examples below, please ensure that you have CSI-UTR and all of its dependencies appropriately installed.  You can follow the installation guide found within the CSI-UTR github page [README file](https://github.com/UofLBioinformatics/CSI-UTR).  Make sure to note the directory in which you have installed CSI-UTR, which will be referred to as <_CSI-UTR_HOME_> for the remainder of this step-by-step example. 
### 1. EXAMPLE 1: HUMAN LATE ONSET ALZHEIMER'S DISEASE (LOAD) DATASET 
Raw reads for this data set can be obtained from the Gene Expression Omnibus (GEO) under the series [GSE6733](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE67333), or through the Sequence Read Archive (SRA) under the accession [SRP056604](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP056604).  This data set consists of two conditions: four biological replicates extracted from hippocampi with late onset Alzheimer’s disease (LOAD) and four age-matched controls. CSI-UTR does not require the raw reads and uses only the alignment of the reads to a reference genome via a BAM file.  You can create your own BAM files if you wish.  You can also download these from the [LOAD_alignments.tar.gz](http://bioinformatics.louisville.edu/LOAD_alignments.tar.gz) tarball file.
### 1.1. Setting up LOAD analysis
Begin setting up the analysis by creating a directory (such as **LOAD_ANALYSIS**) to contain the relevant input and output data.  This directory will be referred to as <_LOAD_ANALYSIS_DIR_>. 
```
mkdir LOAD_ANALYSIS
cd LOAD_ANALYSIS
```


 Within this directory, create a file **sampleInformation.txt** which is a tab-delimited file containing four columns.  The first column contains information about the sample names (this needs to be consistent with the prefix for the alignment file names); the second column contains the experimental description (in this case, either LOAD or CONTROL); the third column contains the replicate number, and the fourth contains information about the number of mapped reads.  The fourth column is not used by CSI-UTR, but may be helpful.  Therefore, if the number of mapped reads for the sample is not known, a default value (such as 1000000) can be used.

For the LOAD dataset, the **sampleInformation.txt** file may look as follows:
```
SRR1931812     LOAD     1     102113986
SRR1931813     LOAD     2     105876277
SRR1931814     LOAD     3     110161965
SRR1931815     LOAD     4     112148433
SRR1931816     Control   1     94279117
SRR1931817     Control   2     68210731
SRR1931818     Control   3     88431481
SRR1931819     Control   4     93054850
```
### 1.2 Mapping Reads to the Reference Genome
CSI-UTR takes as one of its inputs a set of BAM alignment files which contains the alignments for the individual samples to a reference genome.  You can align the samples for the LOAD dataset using your favorite aligner, such as STAR or HiSAT, or TopHat2.   In this case, make sure that you are aligning the input reads for each sample to the hg38 reference genome.  Once you have the bam alignment files, create a directory called 'alignments' under the <_LOAD_ANALYSIS_DIR_> and place all of the bam alignment files there.
```
mkdir alignments
```
The alignments directory should now contain eight bam files.  Note the identity between the prefix of these file names and the sample names in the **sampleInformation.txt** file:
```
SRR1931812.bam
SRR1931813.bam
SRR1931814.bam
SRR1931815.bam
SRR1931816.bam
SRR1931817.bam
SRR1931818.bam
SRR1931819.bam
```
### 1.3 Running CSI-UTR
At this point in time, you are ready to run CSI-UTR.  You can now envoke CSI-UTR with the following command:

```
CSI-UTR -out=<_LOAD_ANALYSIS_DIR_>/results -data-dir=<_LOAD_ANALYSIS_DIR_>/alignments -genome=Hg38 -r=99 -p=0.05 -q=0.05 -annot=<_ANNOTATION_DIR_>/Hg38.CSIs.annot.bed
```

Note that in this case, the directory <_ANNOTATION_DIR_> should point to the location of the installed CSI bed files.

### 2. EXAMPLE 2: MOUSE OPTIC NERVE CRUSH (ONC) DATASET 
Raw reads for this data set can be obtained from the Gene Expression Omnibus (GEO) under the series [GSE55288](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE55228), or through the Sequence Read Archive (SRA) under the accession [SRP038707](https://www.ncbi.nlm.nih.gov/Traces/study/?acc=SRP038707).  This data set consists of two conditions of 2-week-old mice, with one set of three replicates undergoing an optic nerve crush (ONC) procedure to induce axonal injury in the right eye, and the control group of 3 replicates that underwent a sham procedure.  CSI-UTR does not require the raw reads and uses only the alignment of the reads to a reference genome via a BAM file.  You can create your own BAM files if you wish.  You can also download these from the [ONC_alignments.tar.gz](http://bioinformatics.louisville.edu/ONC_alignments.tar.gz) tarball file.

### 2.1. Setting up ONC analysis
Begin setting up the analysis by creating a directory (such as **ONC_ANALYSIS**) to contain the relevant input and output data.  This directory will be referred to as <_ONC_ANALYSIS_DIR_>. 
```
mkdir ONC_ANALYSIS
cd ONC_ANALYSIS
```

 Within this directory, create a file **sampleInformation.txt** which is a tab-delimited file containing four columns.  The first column contains information about the sample names (this needs to be consistent with the prefix for the alignment file names); the second column contains the experimental description (in this case, either Sham or Optic_nerve_crush); the third column contains the replicate number, and the fourth contains information about the number of mapped reads.  The fourth column is not used by CSI-UTR, but may be helpful.  Therefore, if the number of mapped reads for the sample is not known, a default value (such as 1000000) can be used.

For the ONC dataset, the **sampleInformation.txt** file may look as follows:
```
SRR1174021      Sham    1
SRR1174022      Sham    2
SRR1174023      Sham    3
SRR1174024      Optic_nerve_crush       1
SRR1174025      Optic_nerve_crush       2
SRR1174026      Optic_nerve_crush       3
```
### 2.2 Mapping Reads to the Reference Genome
CSI-UTR takes as one of its inputs a set of BAM alignment files which contains the alignments for the individual samples to a reference genome.  You can align the samples for the ONC dataset using your favorite aligner, such as STAR or HiSAT, or TopHat2.   In this case, make sure that you are aligning the input reads for each sample to the mm10 reference genome.  Once you have the bam alignment files, create a directory called 'alignments' under the <_ONC_ANALYSIS_DIR_> and place all of the bam alignment files there.
```
mkdir alignments
```
The alignments directory should now contain six bam files.  Note the identity between the prefix of these file names and the sample names in the **sampleInformation.txt** file:
```
SRR1174021.bam
SRR1174022.bam
SRR1174023.bam
SRR1174024.bam
SRR1174025.bam
SRR1174026.bam
```
### 2.3 Running CSI-UTR
At this point in time, you are ready to run CSI-UTR.  You can now envoke CSI-UTR with the following command:

```
CSI-UTR -out=<_ONC_ANALYSIS_DIR_>/results -data-dir=<_ONC_ANALYSIS_DIR_>/alignments -genome=Mm10 -r=99 -p=0.05 -q=0.05 -annot=<_ANNOTATION_DIR_>/mm10.CSIs.annot.bed
```

Note that in this case, the directory <_ANNOTATION_DIR_> should point to the location of the installed CSI bed files.

### INTERPRETING RESULTS
In both example cases, the output directory will contain a number of files and directories.  The **BED** directory contains the CSI intervals for each sample to be considered.  The **COVERAGE** directory contains one tab-delimited .CSIcoverage file for each of the samples in .BED file format.  The first three  columns of this file contain the chromosome label, begin position, and end position; the fourth column contains the CSI identified; the fifth column is by default 1; the sixth column contains strand information; and the final column is the number of reads falling within the CSI.  An example for the first few lines of the SRR1931812.CSIcoverage is as follows:

```
chr1    965189  965727  ENSG00000187961:965189_965189-965727    1       +       4
chr1    998967  999059  ENSG00000188290:999059_999059-998967    1       -       146
chr1    1014476 1014544 ENSG00000187608:1014476_1014476-1014544 1       +       3
chr1    1070969 1071424 ENSG00000237330:1071817_1071424-1070969 1       -       0
chr1    1071424 1071817 ENSG00000237330:1071817_1071817-1071424 1       -       3
chr1    1081825 1082241 ENSG00000131591:1084019_1082241-1081825 1       -       21
chr1    1082241 1083332 ENSG00000131591:1084019_1083332-1082241 1       -       118
chr1    1083332 1084019 ENSG00000131591:1084019_1084019-1083332 1       -       4
chr1    1185140 1188971 ENSG00000162571:1185140_1185140-1188971 1       +       15
chr1    1188971 1194858 ENSG00000162571:1185140_1188971-1194858 1       +       0
chr1    1203510 1203844 ENSG00000186891:1203844_1203844-1203510 1       -       0
```
The **DEXSeq** directory contains information for gtf files and counts tables used as inputs for the DEXSeq analysis.  The **ExpressedContiguous** directory contains information about CSIs that are contiguously expressed (in effect, an indication of which transcripts are present in a given condition); and the **USAGE** directory contains more detailed information regarding the CSI usage in each sample.

The directory of most interest is the DifferentialExpression directory that contains the following three subdirectories for each of the differential detection methodologies:

- DEXSeq
- PAIRWISE
- WITHIN_UTR

In each of these subdirectories are two files for each pairwise comparison, one of which contains the results for all CSIs, and the second which is filtered for only significant CSIs.  The information contained within these files is slightly different.

As an example, the first few lines of the WITHIN_UTR file for the significant LOAD vs. Control comparison is as follows:

```
CSI     ENSGENE GENE_SYM        PSI1 (LOAD)     PSI2 (Control)  deltaPSI (LOAD-Control) P-value FDR
ENSG00000189241:116278517_116277027-116276921   ENSG00000189241 TSPYL1  0.068122        0.089263        -0.021141       5e-05   0.00679553001277139
ENSG00000189241:116278517_116277126-116277027   ENSG00000189241 TSPYL1  0.086873        0.109091        -0.022218       0.000114        0.012597769470405
ENSG00000189241:116278517_116278517-116277246   ENSG00000189241 TSPYL1  0.505286        0.456247        0.049039        0       0
ENSG00000100796:91458759_91458759-91458147      ENSG00000100796 PPP4R3A 0.580057        0.443966        0.136091        0.000605        0.0425812764550264
ENSG00000174684:66346049_66345714-66345577      ENSG00000174684 B4GAT1  0.314256        0.342451        -0.028195       0.000374        0.0302434133738602
ENSG00000174684:66346049_66346049-66345844      ENSG00000174684 B4GAT1  0.215083        0.177637        0.037446        0       0
ENSG00000119314:112223851_112219214-112219045   ENSG00000119314 PTBP3   0.134671        0.074944        0.059727        3e-06   0.000676385593220339
ENSG00000196652:99532247_99532615-99532684      ENSG00000196652 ZKSCAN5 0.036234        0.11213 -0.075896       6.2e-05 0.00795888540410133
ENSG00000126785:63291182_63291740-63291852      ENSG00000126785 RHOJ    0.047283        0.178141        -0.130858       0.000583        0.0415550529135968
ENSG00000115310:54973156_54972313-54972195      ENSG00000115310 RTN4    0.08397 0.101558        -0.017588       0       0
ENSG00000115310:54973156_54972352-54972313      ENSG00000115310 RTN4    0.144597        0.174865        -0.030268       0       0
ENSG00000115310:54973156_54972948-54972890      ENSG00000115310 RTN4    0.089743        0.076191        0.013552        6.6e-05 0.00830211347517731
```


### REFERENCES
[1] Magistri M, Velmeshev D, Makhmutova M, Faghihi MA. Transcriptomics Profiling of Alzheimer's Disease Reveal Neurovascular Defects, Altered Amyloid-β Homeostasis, and Deregulated Expression of Long Noncoding RNAs. J Alzheimers Dis 2015;48(3):647-65. PMID: [26402107](https://www.ncbi.nlm.nih.gov/pubmed/26402107)

[2]Yasuda M, Tanaka Y, Ryu M, Tsuda S et al. RNA sequence reveals mouse retinal transcriptome changes early after axonal injury. PLoS One 2014;9(3):e93258. PMID: [24676137](https://www.ncbi.nlm.nih.gov/pubmed/24676137)

[3]Harrison BJ, Park JW, Gomes C, Petruska JC, Sapio MR, Iadarola MJ, Chariker JH, Rouchka EC. Detection of Differentially Expressed Cleavage Site Intervals within 3’ Untranslated Regions using CSI-UTR Reveals Regulated Interaction Motifs (under review).
