package vcf;

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