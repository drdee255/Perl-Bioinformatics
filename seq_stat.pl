my $inputFile = $ARGV[0];
my $outputFile = $ARGV[1];

open("FH",$inputFile) or die("File not found");
%hash = {};
while($line=<FH>){
    if($line=~/^>/){
        $header = $line;
        $seq = "";
    }else{
        $seq = $seq.$line
    }
    $hash{$header} = $seq;
}

open(OUT,">$outputFile");

foreach$header(sort keys %hash){
    %count = {};
    $seq = $hash{$header};
    $seq =~ s/\n//g;
    @seq = split("",$seq);
    foreach$letter(@seq){
        $count{$letter}++;
    }
    $header=~s/>//g;
    $header =~ s/\n//g;
    print OUT "$header\t";
    foreach(sort keys %count){
        if($_ !~ m/^HASH/){
            print OUT "$_=$count{$_}\t";
        }
    }
    $lenOfSeq = scalar(@seq);
    print OUT "SequenceLength=$lenOfSeq \n";
}

