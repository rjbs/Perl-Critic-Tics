
use strict;
use warnings;

use Perl::Critic::TestUtils qw(pcritique);
use Test::More;

my @ok = (
  'package Foo; sub process ($@) { }',
);

my @not_ok = (
  'package Foo; sub new { } sub process ($@) { }',
);

plan tests => @ok + @not_ok;

my $policy = 'Tics::ProhibitMethodPrototypes';

for my $i (0 .. $#ok) {
  my $violation_count = pcritique($policy, \$ok[$i]);
  is($violation_count, 0, "nothing wrong with $ok[$i]");
}

for my $i (0 .. $#not_ok) {
  my $violation_count = pcritique($policy, \$not_ok[$i]);
  is($violation_count, 1, "$not_ok[$i] is no good");
}
