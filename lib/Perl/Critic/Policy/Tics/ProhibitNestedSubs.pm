use strict;
use warnings;

package Perl::Critic::Policy::Tics::ProhibitNestedSubs;

=head1 NAME

Perl::Critic::Policy::Tics::ProhibitNestedSubs - sub never { sub correct {} }

=head1 VERSION

version 0.001

=head1 DESCRIPTION

B<Attention would-be clever Perl writers (including Younger RJBS):>

This does not do what you think:

  sub do_something {
    ...
    sub do_subprocess {
      ...
    }
    ...
  }

Either write your subs without nesting or use anonymous code references.

=cut

use Perl::Critic::Utils;
use base qw(Perl::Critic::Policy);

our $VERSION = '0.001';

my $DESCRIPTION = q{Nested named subroutine};
my $EXPLANATION = q{Declaring a named sub inside another named sub does not prevent the inner sub from being global.};

sub default_severity { $SEVERITY_HIGHEST     }
sub default_themes   { qw(tics)              }
sub applies_to       { 'PPI::Statement::Sub' }

sub violates {
  my ($self, $elem, $doc) = @_;

  return unless my $inner = $elem->find_first('PPI::Statement::Sub');

  # Must be a violation...
  return $self->violation($DESCRIPTION, $EXPLANATION, $inner);
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
