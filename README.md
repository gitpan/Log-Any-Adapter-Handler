# NAME

Log::Any::Adapter::Handler

# SYNOPSIS

    use Log::Handler;
    use Log::Any::Adapter::Handler;

    my $lh = Log::Handler->new(screen => {log_to => 'STDOUT'});
    Log::Any::Adapter->set('Handler', logger => $lh);
    my $log = Log::Any->get_logger();

    $log->warn('aaargh!');

# DESCRIPTION

Log::Any adapter for Log::Handler. Log::Handler should be initialized before
calling `set`, otherwise your log messages end up nowhere. The Log::Handler
object is passed via the logger parameter.

# SEE ALSO

[Log::Any](http://search.cpan.org/perldoc?Log::Any), [Log::Any::Adapter](http://search.cpan.org/perldoc?Log::Any::Adapter), [Log::Handler](http://search.cpan.org/perldoc?Log::Handler)
