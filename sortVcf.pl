#/usr/bin/perl


=pod

=head1 DESCRIPTION
	
	This module is for sorting vcf files.In this version,
We can only sort vcf files by chromsome ID(number first,
alphabet second).



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
#open(In,"<$in");
#print "split VCF files\n";

#handleHapmapVcf::SplitVcfByChr($in);

#print "sort VCF files\n";
handleHapmapVcf::SortVcfFile($in);


