use Math::Trig;
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
		push(@residue_no,$2);
		push(@x,$3);
		push(@y,$4);
		push(@z,$5);
	}
}


print N "---------------------------------------------------------------\n\n";
print N "Bond Angles : \n";
print"Atoms \t Residue No. \t Angles \n";
print N "Atoms \t Residue No. \t Angles \n";

for($i=0; $i<scalar(@x)-2; $i++)
{
	# for side a :
	$f =  ($x[$i+1]-$x[$i])**2;
	$s = ($y[$i+1]-$y[$i])**2;
	$t = ($z[$i+1]-$z[$i])**2;
	$a = sqrt($f + $s + $t);
	
	#for side b :
	$f =  ($x[$i+2]-$x[$i+1])**2;
	$s = ($y[$i+2]-$y[$i+1])**2;
	$t = ($z[$i+2]-$z[$i+1])**2;
	$b = sqrt($f + $s + $t);
	
	#for side c :
	$f =  ($x[$i+2]-$x[$i])**2;
	$s = ($y[$i+2]-$y[$i])**2;
	$t = ($z[$i+2]-$z[$i])**2;
	$c = sqrt($f + $s + $t);
	
	#calculating angle ;
	$numerator = (($a**2) + ($b**2) - ($c**2));
	$denominator = 2*$a*$b;
	$angle_in_radian = acos($numerator/$denominator);
	$angle_in_deg = ($angle_in_radian/3.14)*180;
	
	print" $atom[$i]-$atom[$i+1]-$atom[$i+2]\t   $residue_no[$i]-$residue_no[$i+1]-$residue_no[$i+2] \t $angle_in_deg \n";
	print N " $atom[$i]-$atom[$i+1]-$atom[$i+2]\t   $residue_no[$i]-$residue_no[$i+1]-$residue_no[$i+2] \t $angle_in_deg \n";
	
	
	
	
	
}


