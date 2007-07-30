use strict;
use warnings;

use inc::Module::Install;

name          ('Perl-Critic-Tics');
author        ('Ricardo SIGNES <rjbs@cpan.org>');
license       ('perl');
version_from  ('lib/Perl/Critic/Tics.pm');

requires('Perl::Critic'     => 0.21);

WriteAll();
