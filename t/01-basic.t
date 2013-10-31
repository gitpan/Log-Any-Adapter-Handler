#!perl

use strict;
use warnings;

use Test::More;
use Log::Any::Adapter;
use Log::Any::Adapter::Handler;

use_ok('Log::Any::Adapter');
use_ok('Log::Handler');
my @lines;
my $lh = Log::Handler->new(
	forward => {
		forward_to => sub { push @lines, $_[0]->{message} },
		maxlevel => 7
	}
);
isa_ok($lh, 'Log::Handler');
Log::Any::Adapter->set('Handler', logger => $lh);
my $log = Log::Any->get_logger();
isa_ok($log, 'Log::Any::Adapter::Handler');
my @methods = qw(trace debug notice warn error critical alert emergency);
my @methodsf;
map { push @methodsf, $_.'f' } @methods;
can_ok($log, @methods);
can_ok($log, @methodsf);
shift @methods;
shift @methodsf;
map { $log->$_('aaargh!', 'aaarg!') } @methods;
map { ok((shift @lines) =~ /.+$_.+aaargh\!\saaarg\!/i, $_) } @methods;
map { $log->$_('aaargh! %s', 'aaarg!') } @methodsf;
map { ok((shift @lines) =~ /.+$_.+aaargh\!\saaarg\!/i, $_.'f') } @methods;

done_testing();
