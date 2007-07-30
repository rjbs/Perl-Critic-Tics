
use strict;
use warnings;

use Perl::Critic::TestUtils qw(pcritique);
use Test::More;

my @ok = (
  'sub foo { my $bar = sub { 1 } }',
  'sub foo { } sub bar { }',
);

my @not_ok = (
  'sub foo { sub bar { 1 } }',
  'sub foo { if (1) { do { sub bar { 1 } } } }',
);

plan tests => @ok + @not_ok;

my $policy = 'Tics::ProhibitNestedSubs';

for my $i (0 .. $#ok) {
  my $violation_count = pcritique($policy, \$ok[$i]);
  is($violation_count, 0, "nothing wrong with $ok[$i]");
}

for my $i (0 .. $#not_ok) {
  my $violation_count = pcritique($policy, \$not_ok[$i]);
  is($violation_count, 1, "$not_ok[$i] is no good");
}
