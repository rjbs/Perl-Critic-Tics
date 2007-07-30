use strict;
use warnings;

package Perl::Critic::Policy::Tics::ProhibitManyArrows;

=head1 NAME

Perl::Critic::Policy::Tics::ProhibitManyArrows - (this => is => not => good)

=head1 VERSION

version 0.001

=head1 DESCRIPTION

You are not clever if you do this:

  my %hash = (key1=>value1=>key2=>value2=>key3=>'value3');

You are even more not clever if you do this:

  my %hash = (key1=>value1=>key2=>value2=>key3=>value3=>);

=cut

use Perl::Critic::Utils;
use base qw(Perl::Critic::Policy);

our $VERSION = '0.001';

my $DESCRIPTION = q{Too many fat-arrow-separated values in a row};
my $EXPLANATION = q{Fat arrows should separate pairs, not produce long chains
of values};

sub default_severity { $SEVERITY_MEDIUM       }
sub default_themes   { qw(tics)               }
sub applies_to       { 'PPI::Token::Operator' }

sub violates {
  my ($self, $elem, $doc) = @_;

  return unless $elem eq '=>';
  return if eval { $elem->sprevious_sibling->sprevious_sibling } eq '=>';

  my $in_a_row = 1;

  my $start = $elem;
  while (my $next = eval { $start->snext_sibling->snext_sibling }) {
    last unless $next eq '=>';
    $in_a_row++;
    $start = $next;
  }

  return unless $in_a_row > 2; # XXX: make it configurable

  # Must be a violation...
  return $self->violation($DESCRIPTION, $EXPLANATION, $start);
}

=pod

=head1 AUTHOR

Ricardo SIGNES <rjbs@cpan.org>

=head1 COPYRIGHT

Copyright (c) 2007 Ricardo SIGNES.

This program is free software; you can redistribute it and/or modify it under
the same terms as Perl itself.

=cut

1;
