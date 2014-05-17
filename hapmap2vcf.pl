#!/usr/bin/perl


 push (@INC,'pwd');

use Data::Dumper;
 
use hapmap;
use vcf;
use handleHapmapVcf;

$in=shift or die;
$genome=shift or die;
open(In,"<$in");

while(<In>){
	chomp;
	
	if($_=~m/^rs\#/){
	}else{
		
	$hapmap2=hapmap->new();
	$hapmap2=hapmap::readHapmapFile($_);
		
	#$vcf=new vcf;
	$vcf=handleHapmapVcf::convertHapmap2vcf($hapmap2,$genome);
	
	handleHapmapVcf::printVcf($vcf);
	
	}
	
}
close(In);


#for snp annotation
open(In,"<$in");
$DBVcf=shift or die;

%hashDB=handleHapmapVcf::SaveVcfDB($DBVcf);

while(<In>){
	chomp;
	if($_!~m/#/){
	$annotatedVcf=handleHapmapVcf::VcfAnnotation($_);
	handleHapmapVcf::printVcf($annotatedVcf);
	}
}















