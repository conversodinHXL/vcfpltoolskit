package hapmap;

=pod

=head1 DESCRIPTION
	
	This module is for manipulate VCF files, In this version,I write the
vcf class roughly, obviously in the attribute--INFO.For the complexity of
the part. In future, I will rewrite the part and add more vcf format to 
the part.


=head2 Main Function

=over 1

=item C<Create a hapmap class>
we write a class to read hapmap fies, and return a object.
	
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





sub new{

	my($class)=shift;
	my $this={};
	$this->{"rsID"}=undef;
	$this->{"alleles"}=undef;
	$this->{"chrom"}=undef;
	$this->{"pos"}=undef;
	$this->{"strand"}=undef;
	$this->{"assembly"}=undef;
	$this->{"center"}=undef;
	$this->{"protLSID"}=undef;
	$this->{"panelLSID"}=undef;
	$this->{"QCcode"}=undef;
	$this->{"sample"}=undef;

	bless $this,$type;
	
}


#operate one line;
sub readHapmapFile{
	my($Line)=@_;
	
	@contents=split(" ",$Line);
	
	
	$tempHapmap=new hapmap;
	$tempHapmap->{"rsID"}=$contents[0];
	$tempHapmap->{"alleles"}=$contents[1];
	$tempHapmap->{"chrom"}=$contents[2];
	$tempHapmap->{"pos"}=$contents[3];
	$tempHapmap->{"strand"}=$contents[4];
	$tempHapmap->{"assembly"}=$contets[5];
	$tempHapmap->{"center"}=$contets[6];
	$tempHapmap->{"protLSID"}=$contents[7];
	$tempHapmap->{"assayLSID"}=$contents[8];
	$tempHapmap->{"panelLSID"}=$contents[9];
	$tempHapmap->{"QCcode"}=$contents[10];
	
	$i=@contents;
	$j=11;
	$line="";
	while($j<$i){
		$line=$line."\t".$contents[$j];
		$j+=1;
	}
	$tempHapmap->{"sample"}=$line;
		
	return($tempHapmap);
}

1;
