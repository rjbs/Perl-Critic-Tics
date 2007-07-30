use strict;
use warnings;

package Perl::Critic::Policy::Tics::ProhibitLongLines;

=head1 NAME

Perl::Critic::Policy::Tics::ProhibitLongLines - 80 x 40 for life!

=head1 VERSION

version 0.002

=head1 DESCRIPTION

Please keep your code to about eighty columns wide, the One True Terminal
Width.  Going over that occasionally is okay, but only once in a while.

=cut

use Perl::Critic::Utils;
use base qw(Perl::Critic::Policy);

our $VERSION = '0.002';

my $DESCRIPTION = q{Document contains overly-long lines.};
my $EXPLANATION = q{Keep lines to about eighty columns wide.};

sub default_severity { $SEVERITY_LOW   }
sub default_themes   { qw(tics)        }
sub applies_to       { 'PPI::Document' }

sub violates {
  my ($self, $elem, $doc) = @_;

  return unless $elem->serialize =~ /^.{100,}?$/m;

  # Must be a violation...
  return $self->violation($DESCRIPTION, $EXPLANATION, $doc);
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
