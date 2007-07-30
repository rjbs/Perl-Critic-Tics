
use strict;
use warnings;

use Perl::Critic::TestUtils qw(pcritique);
use Test::More;

my @ok = (
  q{$value = $given;},
  q{
$value = $given
       + "this is a longish string that i use for filler"
       .  $some_other_variable
       . sprintf('%s%#b15', $given, $number)
       ;
},
);

my @not_ok = (
  q{$value = $given + "this is a longish string that i use for filler" .  $some_other_variable . sprintf('%s%#b15', $given, $number);},
);

plan tests => @ok + @not_ok;

my $policy = 'Tics::ProhibitLongLines';

for my $i (0 .. $#ok) {
  my $violation_count = pcritique($policy, \$ok[$i]);
  is($violation_count, 0, "nothing wrong with $ok[$i]");
}

for my $i (0 .. $#not_ok) {
  my $violation_count = pcritique($policy, \$not_ok[$i]);
  is($violation_count, 1, "$not_ok[$i] is no good");
}
