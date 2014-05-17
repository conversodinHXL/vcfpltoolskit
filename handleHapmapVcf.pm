package handleHapmapVcf;


=pod

=head1 DESCRIPTION
	
	This module is for handle VCF files, while research, I found that
there are some errors when run GATK to convert hapmap format to VCF
format, so I write this script to solve the problem.	


=head2 Main Function

=over 1

=item C<hapmap2vcf>
we provide a way to convert hapmap-format files to vcf 4.0 files;
	
=item C<snpAnnotation>
annotating snps with knowns vcf,such as dbsnp,1000 genomes,hapmap;
	
=item C<sortVcf>
split and sort vcf files by chromosomes;
	
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


#convert hapmap to vcf
sub convertHapmap2vcf{
	my($hapmapLine,$genome)=@_;
	#print $hapmapLine;
	#print $$hapmapLine;
	
	$newhap=new hapmap;
	$newvcf=new vcf;
	
	$newhap=$hapmapLine;
	
	$newvcf->{"ID"}=$newhap->{"rsID"};
	
	$newvcf->{"chrom"}=$newhap->{"chrom"};
	$newvcf->{"pos"}=$newhap->{"pos"};
	$newvcf->{"qual"}="\.";
	$newvcf->{"INFO"}="\.";
	$newvcf->{"FORMAT"}="GT";
	
	$hapmapSample=$newhap->{"sample"};
	@contents=split("\t",$hapmapSample);
	@alleles="";
	%hashAll="";
	%hashRef="";
	$newvcf->{"ref"}=uc(& getFastaPostion($newvcf->{"chrom"},$newvcf->{"pos"},$genome));
	@potentialALT=split("\/",$newhap->{"alleles"});
	$i=0;
	$TrueALT="";
	$TrueALT1="";
	while($ALT=shift(@potentialALT)){
		if($ALT eq $newvcf->{"ref"})
		{
		}else{
			$TrueALT=$ALT;
			$hash{$ALT}=$i+1;
			$i+=1;
		}
		if($i>1){
			$TrueALT1=$TrueALT1.",".$TrueALT;
		}else{	
			$TrueALT1=$TrueALT;
		}

		
	}
	$newvcf->{"ALT"}=$TrueALT1;
	
	
	$a="";
	$line="";
	while($RA=pop(@contents)){
		@RAall=split("",$RA);
		
		#for ref;
		if($RAall[0] eq $newvcf->{"ref"}){
			$a="0/";
		}elsif(exists $hash{$RAall[0]}){$a="$hash{$RAall[0]}/";}
		
		#for ALT;
		if($RAall[1] eq $newvcf->{"ref"}){
			$a=$a."0";
		}
		elsif(exists $hash{$RAall[1]}){$a=$a."$hash{$RAall[1]}";}
		
		if($RAall[0] eq "N" && $RAall[1] eq "N"){$a="./.";}
		$line=$line."\t".$a;
		
		
	}
	
	$newvcf->{"sample"}=$line;

	return $newvcf;	
}

#AnnotationVcfFile;
sub VcfAnnotation{
	my($RawVcfLine,%hashVcfDB)=@_;
	
	$RawVcf=vcf::readvcfFile($RawVcfLine);
	$RawKey=$RawVcf->{"chrom"}."\t".$RawVcf->{"pos"}."\t".$RawVcf->{"ref"}."\t".$RawVcf->{"ALT"};
	if(exists $hashVcfDB{$RawKey}){
		$RawVcf->{"INFO"}=$RawVcf->{"INFO"}."Annotation: ".$hashVcfDB{$RawKey};
	}else{
		$RawVcf->{"INFO"}=$RawVcf->{"INFO"}."Annotation: "."noRecords founds";
	}
	
	return($RawVcf);
}

#readAndSavevcfDB;
sub SaveVcfDB{
	my($vcfDBname)=@_;
	
	open(DB,"<$vcfDBname");
		
	while(<DB>){
		if($_!~m/##/){
		$vcfContent=vcf::readvcfFile($_);
		
		
		$hashKey=$vcfContent->{"chrom"}."\t".$vcfContent->{"pos"}."\t".$vcfContent->{"ref"}."\t".$vcfContent->{"ALT"};
		$hashDB{$hashKey}=$vcfContent->{"INFO"};

		}
	}
	
	return %hashDB;
}


sub SplitVcfByChr{
	my($VcfName)=@_;
	
	`rm -rf *_split.vcf`;
	
	$j=1;
	open(VcfIn,"<$VcfName");
	while(<VcfIn>){
		if($_=~m/#/){$header.=$_;$i=1;}
		else{
			@contents=split("\t",$_);
			if($chrName ne $contents[0]){
				#print  $fileName."\n";
				open(Out,">>$fileName");
				print Out $header;
				print Out $VCFChr;
				$VCFChr="";
				close(Out);
			}elsif(eof(VcfIn) && $j==1){
				#print  $fileName."\n";
				open(Out,">>$fileName");
				print Out $header;
				print Out $VCFChr;
				$VCFChr="";
				close(Out);
				$j=2;
			}
			$chrName=$contents[0];
			$fileName=$chrName."_split\.vcf";
			$chrName=~s/chr//;
			if($chrName^$chrName eq 0 ){
			$hashSplitFileNames{$chrName}=undef;
			}else{
			$hashSplitFileNames{ord($chrName)}=undef;
			}
			$chrName="chr".$chrName;
			$VCFChr.=$_;
			
		}
	}
	return %hashSplitFileNames;
	
}

sub SortVcfFile{
	my($VcfName)=@_;
	$VcfOutName="output.sort.vcf";
	open(Out1,">$VcfOutName");
	my %TempFiles=&SplitVcfByChr($VcfName);

	my $i=1;
	foreach $FileName1(sort {$a<=>$b}keys %TempFiles){
		if($FileName1 > 65 && $FileName1 < 122){
		$FileName="chr".chr($FileName1)."_split\.vcf";
		}else{	
			$FileName="chr".$FileName1."_split\.vcf";
		}
		open(In,"<$FileName");
		#print $FileName."\n";
		$header="";
		while(<In>){
			if($_=~m/#/){$header.=$_;}
			else{
				if($i==1){
					print  $header;
					$i=2;
				}
				my @contents=split("\t",$_);
				$hashToSort{$contents[1]}=$_;
				}
		}
		close(In);
		foreach $key (sort {$a<=>$b} keys %hashToSort){
			$line.=$hashToSort{$key};
		}
		print  $line;
		$line="";
		%hashToSort="";
		
	}
	close(Out);
}



#this part is to filter the VCF;
sub FilterVcf{
	my($VcfLine,$Filter,$FilterAction,$FilterStand)=@_;
	
	my $VcfTemp=new vcf;
	$VcfTemp=vcf::readvcfFile($VcfLine);


}	
	
	












sub getFastaPostion{
	my($chrom,$positipn,$genomeFasta)=@_;
	$genomePostion=$chrom.":".$positipn."-".$positipn;
	$nr=`samtools faidx $genomeFasta $genomePostion`;
	@nt=split("\n",$nr);
	return $nt[1];
}
	
sub printVcf{
	my($vcf)=@_;
	
	
	print $vcf->{"chrom"}."\t";
	print $vcf->{"pos"}."\t";
	print $vcf->{"ID"}."\t";
	print $vcf->{"ref"}."\t";
	print $vcf->{"ALT"}."\t";
	print $vcf->{"qual"};
	print $vcf->{"FILTER"}."\t";
	print $vcf->{"INFO"}."\t";
	print $vcf->{"FORMAT"};
	print $vcf->{"sample"}."\n";
}
	
1;