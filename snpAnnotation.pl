#!/usr/bin/perl

=pod

=head1 DESCRIPTION
	
	This script contains only one function.
	It is very useless.Because I wrote annotation with hashtable.I have
tested the memory-using,it is too high to bear.I prepare to rewrite the module in future with
mongoDB.
	So, NEVER use this scrpit until I finish database-version.
	
=head2 Main Function

=over 1
	
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
