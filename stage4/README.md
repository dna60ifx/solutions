Stage 4: Recommended Solution
=============================

The easiest solution is to use the BLASTN workflow from CAMERA: https://portal.camera.calit2.net

See CAMERA_RESULTS.zip for the output from their workflow

Then, you can simply parse the blast results to identify the most frequent genus:
```bash
$ grep Hit_def blastResults.xml  | cut -f 2 -d'"' | awk '{print $1}' | sort | uniq -c | sort -nrk1 | head
92711 Helicobacter
3035 Bacillus
2166 Streptomyces
1239 Paenibacillus
 912 Arthrobacter
 797 Salmonella
 785 Lactobacillus
 716 Cronobacter
 704 Enterobacter
 500 Microbacterium
```








