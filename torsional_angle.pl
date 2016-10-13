use Math::Trig;

print"Enter pdb file name(without extension) : \n";
chomp($file_name=<>);
open(D,"$file_name.pdb");
open(N,">>Output.txt");
@a=<D>;

#ATOM      1  N   ALA A   1       7.273  -0.781   1.149  1.00 20.00           N1+
foreach(@a)
{
	if($_ =~/^ATOM\s+\d+\s+(N|CA|C)\s+(\w+)\s+\w+\s+(\d+)\s+(\S+)\s+(\S+)\s+(\S+)/)
	{
		push(@atom,$1);
		push(@residue,$2);
		push(@residue_no,$3);
		push(@x,$4);
		push(@y,$5);
		push(@z,$6);
	}
}

#@angle_labels = ('psi(ψ)','omega(ω)','phi(φ)');

for($i=0; $i<scalar(@x)-3; $i++)
{
	push(@angle_labels,'psi(ψ)');
	push(@angle_labels,'omega(ω)');
	push(@angle_labels,'phi(φ)');
}


print"Torsional angles :\n ";
print"Atoms \t \t Residue No.\t  Torsional Angle \n";

print N "--------------------------------------------------------------\n\n";

print N "Torsional angles :\n \n ";
print N "Atoms \t \t Residue No.\t  Torsional Angle \n";


for($i=0; $i<scalar(@x)-3; $i++)
{
	#for v1 :
	$v1i = $x[$i+1]-$x[$i];
	$v1j = $y[$i+1]-$y[$i];
	$v1k = $z[$i+1]-$z[$i];
	
	#for v2 :
	$v2i = $x[$i+2]-$x[$i+1];
	$v2j = $y[$i+2]-$y[$i+1];
	$v2k = $z[$i+2]-$z[$i+1];
	
	#for v3 :
	$v3i = $x[$i+3]-$x[$i+2];
	$v3j = $y[$i+3]-$y[$i+2];
	$v3k = $z[$i+3]-$z[$i+2];
	
	#doing cross products :
	#v1*v2 :
	$v1_cross_v2_i = ($v1j*$v2k)-($v1k*$v2j);
	$v1_cross_v2_j = ($v1i*$v2k)-($v2i*$v1k);
	$v1_cross_v2_k = ($v1i*$v2j)-($v1j*$v2i);
	#v2*v3 :
	$v2_cross_v3_i = ($v2j*$v3k)-($v2k*$v3j);
	$v2_cross_v3_j = ($v2i*$v3k)-($v3i*$v2k);
	$v2_cross_v3_k = ($v2i*$v3j)-($v2j*$v3i);
	
	#putting in formulae :
	$dot_product_numerator = ($v1_cross_v2_i * $v2_cross_v3_i) + ($v1_cross_v2_j * $v2_cross_v3_j) + ($v1_cross_v2_k * $v2_cross_v3_k);
	$mag_of_v1_cross_v2 = sqrt((($v1_cross_v2_i)**2)+(($v1_cross_v2_j)**2)+(($v1_cross_v2_k)**2));
	$mag_of_v2_cross_v3 = sqrt((($v2_cross_v3_i)**2)+(($v2_cross_v3_j)**2)+(($v2_cross_v3_k)**2));
	$denominator = $mag_of_v1_cross_v2 * $mag_of_v2_cross_v3;
	
	$angle_in_deg = (acos($dot_product_numerator/$denominator))*57.2958;
	print"$atom[$i]-$atom[$i+1]-$atom[$i+2]-$atom[$i+3] \t $residue_no[$i]-$residue_no[$i+1]-$residue_no[$i+2]-$residue_no[$i+3] \t $angle_in_deg $angle_labels[$i]\n";
	print N "$atom[$i]-$atom[$i+1]-$atom[$i+2]-$atom[$i+3] \t $residue_no[$i]-$residue_no[$i+1]-$residue_no[$i+2]-$residue_no[$i+3] \t $angle_in_deg $angle_labels[$i]\n";
}
