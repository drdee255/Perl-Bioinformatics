print"Enter pdb file name(without extension) : \n";
chomp($file_name=<>);
open(D,"$file_name.pdb");
open(N,">>Output.txt");
@a=<D>;


#ATOM      1  N   ALA A   1       7.273  -0.781   1.149  1.00 20.00           N1+
foreach(@a)
{
	if($_ =~/^ATOM\s+\d+\s+(N|CA|C)\s+\w+\s+\w+\s+(\d+)\s+(\S+)\s+(\S+)\s+(\S+)/)
	{
		push(@atom,$1);
		push(@res_num,$2);
		push(@x,$3);
		push(@y,$4);
		push(@z,$5);
	}
}

print N "--------------------------------------------------------------\n\n";
print N "Bond Lengths :\n";
print"Atoms\tResidue number\t\t Distance\n";
print N "Atoms\tResidue number\t\t Distance\n";

for($i=0; $i<scalar(@x)-1; $i++)
{
	$f =  ($x[$i+1]-$x[$i])**2;
	$s = ($y[$i+1]-$y[$i])**2;
	$t = ($z[$i+1]-$z[$i])**2;
	$d = sqrt($f + $s + $t);
	print"$atom[$i]-$atom[$i+1]\t\t$res_num[$i]-$res_num[$i+1]\t\t $d \n";
	print N "$atom[$i]-$atom[$i+1]\t\t$res_num[$i]-$res_num[$i+1]\t\t $d \n";
}


