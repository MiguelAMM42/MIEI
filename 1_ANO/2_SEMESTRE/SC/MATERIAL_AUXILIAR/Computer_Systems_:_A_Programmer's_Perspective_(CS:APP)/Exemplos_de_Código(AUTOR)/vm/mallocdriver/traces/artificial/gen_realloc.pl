#!/usr/bin/perl

$out_filename = "incremental2.rep";
$realloc_size = 512;
$size_increment = 8;
$num_iters = 4800;

# Open output file
open OUTFILE, ">$out_filename" or die "Cannot create $out_filename\n";

# Calculate misc parameters

$suggested_heap_size = num_iters* ($realloc_size+$size_increment*2 )+100;
$num_blocks = $num_iters;
$num_ops = ($num_iters )*3 ;

print OUTFILE "$suggested_heap_size\n"; 
print OUTFILE "$num_blocks\n";
print OUTFILE "$num_ops\n";
print OUTFILE "1\n"; 

for ($i = 0;  $i < $num_iters; $i += 1) { 
       print OUTFILE "a $i $realloc_size\n");
}

$realloc_size += $size_increment;

for ($i = 0;  $i < $num_iters; $i += 1) { 
       print OUTFILE "r $i $realloc_size\n");
}

$realloc_size += $size_increment;
for ($i = 0;  $i < $num_iters; $i += 1) { 
       print OUTFILE "r $i $realloc_size\n");
}

close OUTFILE;
