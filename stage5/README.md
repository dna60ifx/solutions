Stage 5 Recommended Solution
===========================

Install ALLPATHS-LG from: http://www.broadinstitute.org/software/allpaths-lg/blog/?page_id=12
Install MUMmer from: http://mummer.sourceforge.net/
Install SAMTools from: http://samtools.sourceforge.net/


1. First assemble the genome with ALLPATHS-LG using the in_libs.csv and in_groups.csv files

```bash
$ PrepareAllPathsInputs.pl DATA_DIR=`pwd` PLOIDY=1
$ RunAllPathsLG PRE=`pwd` REFERENCE_NAME=. DATA_SUBDIR=. RUN=default THREADS=12
```

Note this assembles into 1 contig:
```bash
$ grep '>' default/ASSEMBLIES/test/final.contigs.fasta
>contig_0
```

2. Then BLAST the contig file at NCBI against the NR database. The top hit will be to the
Wolbachia endosymbiont of Drosophila ananassae gdan_438, whole genome shotgun sequence
GenBank: AAGB01000001.1: http://www.ncbi.nlm.nih.gov/nuccore/gi%7C58535391


3. Download the genome from GenBank and align your contig to the reference:

```bash
$ nucmer ref.fa check/default/ASSEMBLIES/test/final.contigs.fasta -p ref_v_asm >& /dev/null
$ show-coords -rclo ref_v_asm.delta

$ show-coords -rclo ref_v_asm.delta
NUCMER

    [S1]     [E1]  |     [S2]     [E2]  |  [LEN 1]  [LEN 2]  |  [% IDY]  |  [LEN R]  [LEN Q]  |  [COV R]  [COV Q]  | [TAGS]
===============================================================================================================================
     836    25678  |        1    24843  |    24843    24843  |    99.99  |    46795    47891  |    53.09    51.87  | gi|58535391|gb|AAGB01000001.1|	contig_0
   25678    46774  |    26795    47891  |    21097    21097  |   100.00  |    46795    47891  |    45.08    44.05  | gi|58535391|gb|AAGB01000001.1|	contig_0
```

4. This shows the assembled contig has 2 alignments: 1-24843 and 26795-47891. The piece in the middle contains the insertion.
Use samtools to extract the inserted nucleotides and the dna-encode script to convert to english


```bash
$ samtools faidx check/default/ASSEMBLIES/test/final.contigs.fasta
$ samtools faidx check/default/ASSEMBLIES/test/final.contigs.fasta contig_0:24844-26794 | ./dna-encode.pl -d
>contig_0:24844-26794
We went up, saw the structure, we came back to King’s and looked at our Pattersons, and every section of our Pattersons we looked at screamed at you, “Double Helix!” And it was just there! - once you knew what to look for. It was amazing.
```
