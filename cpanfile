requires 'perl', '5.008001';
requires 'strict';
requires 'warnings';
requires 'parent';
requires 'Log::Any::Adapter', '<= 0.11';
requires 'Log::Handler';

on configure => sub {
	requires 'Module::Build';
};

on build => sub {
	requires 'Test::More', '0.98';
};
