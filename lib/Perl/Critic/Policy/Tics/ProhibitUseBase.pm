use strict;
use warnings;

package Perl::Critic::Policy::Tics::ProhibitUseBase;

=head1 NAME

Perl::Critic::Policy::Tics::ProhibitUseBase - do not use base.pm

=head1 VERSION

version 0.001

=head1 DESCRIPTION

  use base qw(Baseclass);

You've seen that a hundred times, right?  That doesn't mean that it's a good
idea.  It screws with C<$VERSION>, it (temporarily) clobbers your
C<$SIG{__DIE__}>, it doesn't let you call the base class's C<import> method, it
pushes to C<@INC> rather than replacing it, and it devotes much of its code to
handling the nearly totally unused L<fields|fields> pragma -- but the multiple
inheritence that pushing to C<@INC> sets up is not supported by fields.

There are a lot of ways around using C<base>.  Pick one.

=cut

use Perl::Critic::Utils;
use base qw(Perl::Critic::Policy);

our $VERSION = '0.001';

my $DESCRIPTION = q{Use of "base" pragma};
my $EXPLANATION = q{Don't use base, set @INC or use a base.pm alternative.};

sub default_severity { $SEVERITY_MEDIUM          }
sub default_themes   { qw(tics)                  }
sub applies_to       { 'PPI::Statement::Include' }

sub violates {
  my ($self, $elem, $doc) = @_;

  return unless $elem->module eq 'base';

  # Must be a violation...
  return $self->violation($DESCRIPTION, $EXPLANATION, $elem);
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
