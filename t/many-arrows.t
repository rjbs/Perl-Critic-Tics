
use strict;
use warnings;

use Perl::Critic::TestUtils qw(pcritique);
use Test::More;

my @ok = (
  q{%hash = (key => 'value', key2 => 'value2');},
);

my @not_ok = (
  q{%hash = (key => value => key2 => value2 =>);},
  q{%hash = (key => value => key2 => 'value2');},
);

plan tests => @ok + @not_ok;

my $policy = 'Tics::ProhibitManyArrows';

for my $i (0 .. $#ok) {
  my $violation_count = pcritique($policy, \$ok[$i]);
  is($violation_count, 0, "nothing wrong with $ok[$i]");
}

for my $i (0 .. $#not_ok) {
  my $violation_count = pcritique($policy, \$not_ok[$i]);
  is($violation_count, 1, "$not_ok[$i] is no good");
}
