vcfpltoolskit is a summary of perl codes, which aim to manipulate vcf 4.0 files.

===============================================================================

Now it contains format convertion(hapmap to vcf 4.0),spliting vcf files according chromosome ID, sorting vcf files, annotatingn vcf files. 
what's I want to add are as below: 
rewrite the annotation module with database, it will increase the speed and reduce the memery using;a merge module and so on.

==============================================================================
To use those scripts, samtools is required. I use the software to get the refrence nucletide(s).

===============================
I submit both pm files and pl files. The main thing I want to contribute is my pm files. The pl file is just a example.

================================
Never use annotation module until I rewrite the module, I will use database instead of hashtable.I use spliting annotion,
but it is not so efficient.
