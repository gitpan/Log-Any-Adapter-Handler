package Log::Any::Adapter::Handler;
# ABSTRACT: Log::Any::Adapter for Log::Handler
our $VERSION = '0.002';

use strict;
use warnings;

use Log::Any::Adapter::Util qw(make_method);
use base qw(Log::Any::Adapter::Base);
use Log::Handler;

sub init {
	my $self = shift;
	$self->{logger} ||= Log::Handler->new;
}

# logging methods
foreach my $method (Log::Any->logging_methods) {
	my $handler_method = $method;
	make_method($method, sub {
		my $self = shift;
		return $self->{logger}->$handler_method(@_);
	});
}

# detection methods
foreach my $method (Log::Any->detection_methods) {
	my $self = shift;
	my $handler_method = $method;
	make_method($method, sub {
		my $self = shift;
		return $self->{logger}->$handler_method(@_);
	});
}

1;

__END__

=encoding utf8

=head1 NAME

Log::Any::Adapter::Handler

=head1 SYNOPSIS

  use Log::Handler;
  use Log::Any::Adapter::Handler;

  my $lh = Log::Handler->new(screen => {log_to => 'STDOUT'});
  Log::Any::Adapter->set('Handler', logger => $lh);
  my $log = Log::Any->get_logger();

  $log->warn('aaargh!');

=head1 DESCRIPTION

This is a L<Log::Any> adapter for L<Log::Handler>. Log::Handler should be
initialized before calling C<set>, otherwise your log messages end up nowhere.
The Log::Handler object is passed via the logger parameter.

=head1 SEE ALSO

L<Log::Any>, L<Log::Any::Adapter>, L<Log::Handler>

=cut
