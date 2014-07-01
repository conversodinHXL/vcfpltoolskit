package vcf;

=pod

=head1 DESCRIPTION
	
	This module is for manipulate VCF files, In this version,I write the
vcf class roughly, obviously in the attribute--INFO.For the complexity of
the part. In future, I will rewrite the part and add more vcf format to 
the part.


=head2 Main Function

=over 1

=item C<Create a vcf class>
we write a class to read vcf fies, and return a object.
	
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



sub new {
	my($class)=shift;
	$this={};
	
	$this->{"ID"}=undef;
	$this->{"ALT"}=undef;
	$this->{"ref"}=undef;
	$this->{"chrom"}=undef;
	$this->{"pos"}=undef;
	$this->{"qual"}=undef;
	$this->{"INFO"}=undef;
	$this->{"FORMAT"}=undef;
	$this->{"sample"}=undef;
	$this->{"FILTER"}=undef;
	
	bless $this,$class;
	
}

sub readvcfFile{
	my($vcfLine)=@_;
	
	@contents=split("\t",$vcfLine);
	
	$vcftemp=new vcf;
	$vcf->{"ID"}=$contents[2];
	$vcf->{"ALT"}=$contents[4];
	$vcf->{"ref"}=$contents[3];
	$vcf->{"chrom"}=$contents[0];
	$vcf->{"pos"}=$contents[1];
	$vcf->{"qual"}=$contents[5];
	$vcf->{"INFO"}=$contents[7];
	$vcf->{"FORMAT"}=$contents[8];
	$vcf->{"FILTER"}=".";
	
	my $i=@contents;
	my $j=10;
	my $line="";
	while($j<$i){
		$line=$line."\t".$contents[$j];
		$j+=1;
	}
	$vcf->{"sample"}=$line;
	
	return $vcf;
}

1;
