#!/usr/bin/perl


push (@INC,'pwd');

use Data::Dumper;
 
use hapmap;
use vcf;
use handleHapmapVcf;

$in=shift or die;
open(In,"<$in");
$DBVcf=shift or die;

print "make known snp hash table;\n";
%hashDB=handleHapmapVcf::SaveVcfDB($DBVcf);
print "Start annotations;\n";
while(<In>){
	chomp;
	if($_!~m/#/){
	$annotatedVcf=handleHapmapVcf::VcfAnnotation($_,\%hashDB);
	handleHapmapVcf::printVcf($annotatedVcf);
	}
}