# -*- perl -*-

use Test::More tests => 7;
#use Test::More 'no_plan';

use Module::TestConfig;

$ENV{TESTCONFIG_FIVE} ||= 5;

ok $t = Module::TestConfig->new( questions => [
	[ qw/One?   one/, { validate => { one => 1 }} ],
	[ qw/Two?   two/, { validate => { two => 0 }} ],
	[ qw/Three? three x/, { validate => { three => sub { /^\d+$/ }}} ],
	[ qw/Four?  four  4/, { validate => { four => sub { /^\d+$/ }}} ],
	[ qw/Five?  testconfig_five x/, { validate => { testconfig_five => sub { /^\d+$/ }}} ],
   ],
   order => [ qw/env defaults/ ],
   defaults => 't/etc/defaults.config',
), 				"new()";

close STDIN or warn $!;		# query noninteractively.

ok $t->ask,			 "ask()";
is $t->answer( 'one' ), 1,	 "answer(1) from file";
is $t->answer( 'two' ), 2,	 "answer(2) from file";
is $t->answer( 'three' ), 3,	 "answer(3) from file";
is $t->answer( 'four' ), 4,	 "answer(4) from default";
is $t->answer( 'testconfig_five' ), 5,	 "answer(5) from env";
