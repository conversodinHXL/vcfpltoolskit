package hapmap;

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