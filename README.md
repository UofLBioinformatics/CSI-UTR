
# CSI-UTR
A pipeline for detecting differential expression of 3-prime UTRs

<img src="http://bioinformatics.louisville.edu/lab/localresources/images/CSIUTRHDR.png"></img>

CSI-UTR v1.1.0

Last Updated: 4/23/2018

Please Cite:

Harrison BJ, Park JW, Gomes C, Petruska JC, Sapio MR, Iadarola MJ, Chariker JH, Rouchka EC. (2018) Detection of differentially expressed cleavage site intervals within 3' untranslated regions using CSI-UTR reveals regulated interaction motifs. Under Review.                                  

(C) 2015-2018, University of Louisville.

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
    
# MOTIVATION
Untranslated regions of the 3' end of transcripts (3'UTRs) are critical for controlling transcript abundance and location. 3'UTR configuration is highly regulated and provides functional diversity, similar to alternative splicing of exons. Detailed transcriptome-wide profiling of 3'UTR structures may help elucidate mechanisms regulating cellular functions. This profiling is more difficult than for coding sequences (CDS), where exon/intron boundaries are well-defined. To enable this we developed a new approach, CSI-UTR. Meaningful configurations of the 3'UTR are determined using cleavage site intervals (CSIs) that lie between functional alternative polyadenylation (APA) sites. The functional APAs are defined using publicly available polyA-seq datasets biased to the site of polyadenylation. CSI-UTR can be applied to any RNASeq dataset, regardless of the 3' bias.

# RESULTS
Using CSI-UTR, we produced a pre-defined set of CSIs for human, mouse, and rat. Previous studies indicate 3'UTR structure is highly regulated during nervous system functions. We therefore assessed CSI-UTR using archived RNASeq datasets from the nervous system (SRP056604, SRP038707, and SRP055912) and a rat dataset of our own. In all three species, CSI-UTR identified differential expression (DE) events not detected by standard gene-based differential analyses. Many DE events were in transcripts in which the CDS was unchanged. Enrichment analyses determined these DE 3'UTRs are associated with genes with known roles in neural processes. CSI-UTR is a pow-erful new tool to uncover DE that is undetectable by standard pipelines, but can exert a major influence on cellular function.

Supported by the National Institutes of Health (NIH) grants P20GM103436, P20GM103643, R01NS094741, and P30GM103507 (supporting core facilities of the KSCIRC) and the Intramural Research Program, Clinical Center, NIH. The contents of this work are solely the responsibility of the developers and do not represent the official views of the funding organization.

# REQUREMENTS
CSI-UTR requires the following:
<ul>
  <li>samtools</li>
  <li>BedTools (v2.24.0 or later) (https://github.com/arq5x/bedtools2)</li>
  <li>perl (5.12.13 or later)</li>
  <li>R</li>
</ul>

In addition, a number of perl packages are required, including:
<ul>
   <li>List::MoreUtils                                   : 0.33</li>
   <li>Getopt::Long                                      : 2.38</li>
   <li>MIME::Base64                                      : 3.08 </li>
<li>Statistics::TTest                                 : 1.1</li>
<li>Text::NSP::Measures::2D::Fisher::twotailed        : 0.97</li>
<li>Statistics::Multtest                              : 0.13</li>
<li>File::Which                                       : 1.09</li>
</ul>

Required R libraries inlcude:
<ul>
<li>DESeq2</li>
<li>DEXSeq</li>
</ul>
Please run the file checkDependencies to make sure all of the required packages are available

# INSTALLATION
CSI-UTR is distributed as a tarball.  

In order to unpack the files, run: tar xvf CSI-UTR.tar.gz This will create a CSI-UTR_vx.x.x directory. Inside this directory is an executable file checkDependencies that should be run to ensure that perl, and all of the perl packages are installed.

# DIRECTORY STRUCTURE
<ul>
<li>bin/			Location of CSI-UTR executable</li>
<li>data/annotations	Annotated CSI BED files for Rat, Mouse, Human	</li>
<li>data/locations		CSI BED location files for Rat, Mouse, Human</li>
</ul>

# SETTING UP CSI-UTR
In order to run CSI-UTR, you will need to provide two sets of input.  The first is a set of high-throughput sequence alignments in .bam format, located in a user-specified data directory (current directory by default).  Index bam files are required.  if .bam.bai files are missing, the .bam files will be sorted and indexed using samtools.

It is recommended that this bam file be parsed to contain only uniquely mapped reads.

The second piece of information is a file sampleInformation.txt

This file is a tab-delimited file containing the following information:
FilePrefix	ConditionLabel	ReplicateNumber

In this case, the data is set up as follows:
<ul>
   <li>FilePrefix is the name of the .bam files, minus the .bam extension</li>
   <li>ConditionLabel is used to group samples together</li>
   <li>ReplicateNumber is the replicate number for the specified group</li>
</ul>

An example sampleInformation.txt file is provided.

# RUNNING CSI-UTR
From the CSI-UTR home directory, run the executable perl script:
./bin/CSI-UTR with the following options:

   options:
   
      -genome=<genome>                    (default: Rn6 -- Other options are Mm10, Hg38, Rn6_extended)
      -r=<read_length>                    (default: 75)
      -sample_info=<sample_info_table_fn> (default: sampleInformaton.txt)
      -bed=<CSI_bed_file>                 (default: ./data/locations/Rn6.CSIs.bed)
      -annot=<CSI_annotation_file>        (default: ./data/annotations/Rn6.CSIs.annot.bed)
      -out=<output directory>             (default: ./CSI_OUT/)
      -data_dir=<input directory>         (default: ./)
      -coverage_cut=<coverage cutoff>     (default: 0.08)
      -usage_cut=<usage cutoff>           (default: 1.0)
      -p=<p value significance cutoff)    (default: 0.05)
      -q=<FDR significance cutoff)        (default: 0.10)

      --h Print this help screen
      --v Print version information

Within the output directory, a DifferentialExpression directory will be created with two sub-directories:
<ul>
<li>PAIRWISE   (pairwise comparision between each group represented)</li>
<li>WITHIN_UTR (compares expression within individual CSIs for differential UTR expression)</li>
<li>DEXSeq     (compares CSI usage using the DEXSeq and DESeq2 method for exon usage)</li>
  </ul>
