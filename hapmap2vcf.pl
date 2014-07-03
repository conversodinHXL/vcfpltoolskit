#!/usr/bin/perl

=pod

=head1 DESCRIPTION
	
	This script contains two function. the first is converting hapmap files to
vcf(4.0) files. the second is annotation.
	The second is very useless.Because I wrote annotation with hashtable.I have
test the memory-using is to high.I prepare to rewrite the module in future with
mongoDB.
	So, NEVER use this scrpit until I finish database-version.
	
=head2 Main Function

=over 1
=item C<hapmap2vcf>
we provide the example script to convert hapmap-format files to vcf 4.0 files;
	
=item C<snpAnnotation>
we provide the example script to annotate snps with knowns vcf,such as dbsnp,1000 genomes,hapmap;
	
=back

=head1 LICENSE

=head1 AUTHOR:
Hu XiaoLin	L<conversodin66@gmail.com>

=head1 SEE ALSO

=over 12

=item C<NCBI dbSNP>
	L<http://www.ncbi.nlm.nih.gov/SNP/>


=item C<1000 genomes>
	L<http://www.1000genomes.org/>
	
=item C<hapmap>
	L<http://hapmap.ncbi.nlm.nih.gov/>
	
=back










=cut 



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















