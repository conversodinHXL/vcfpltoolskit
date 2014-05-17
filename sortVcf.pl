#/usr/bin/perl

push (@INC,'pwd');

use Data::Dumper;
 
use hapmap;
use vcf;
use handleHapmapVcf;

$in=shift or die;
#open(In,"<$in");
#print "split VCF files\n";

#handleHapmapVcf::SplitVcfByChr($in);

#print "sort VCF files\n";
handleHapmapVcf::SortVcfFile($in);


