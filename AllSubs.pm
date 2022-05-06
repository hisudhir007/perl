
# How to use this code?
# Save below code as Devel/MyTrace.pm
# Then call any perl program - /usr/software/bin/perl5.14.0 -d:MyTrace tbs -c scspr2496766015
# debugger will identify the script MyTrace and start dumping the trace output in  mytrace.$$

package Devel::AllSubs;
use v5.10;
use autodie;

BEGIN {
my $trace_file = $ENV{TRACE_FILE} // "mytrace.$$";
print STDERR "Saving trace to $trace_file\n";

my $fh = do {
       if( $trace_file eq '-'      ) { \*STDOUT }
    elsif( $trace_file eq 'STDERR' ) { \*STDERR }
    else {
        open my $fh, '>>', $trace_file;
        $fh;
        }   
    };  

sub DB::DB {
    my ($pkg, $file, $line,$sub) = caller(1);
    if ($sub ne $last_sub) {
      print $fh "$file::$sub\n";
      $last_sub = $sub;
    }   
   }   
}
1;
