
use strict;
use warnings;

use 5.008;

use ExtUtils::MakeMaker 6.30;



my %WriteMakefileArgs = (
  "ABSTRACT" => "Interactively prompt user to generate a config module",
  "AUTHOR" => "Joshua Keroes <joshua\@cpan.org>",
  "BUILD_REQUIRES" => {},
  "CONFIGURE_REQUIRES" => {
    "ExtUtils::MakeMaker" => "6.30"
  },
  "DISTNAME" => "Module-TestConfig",
  "EXE_FILES" => [],
  "LICENSE" => "perl",
  "NAME" => "Module::TestConfig",
  "PREREQ_PM" => {
    "Carp" => 0,
    "Config::Auto" => 0,
    "Data::Dumper" => 0,
    "Fcntl" => 0,
    "File::Basename" => 0,
    "File::Path" => 0,
    "Params::Validate" => 0,
    "Term::ReadKey" => 0,
    "Text::FormatTable" => 0,
    "strict" => 0,
    "warnings" => 0
  },
  "TEST_REQUIRES" => {
    "Test::More" => 0,
    "Test::Warn" => 0
  },
  "VERSION" => "0.06_01",
  "test" => {
    "TESTS" => "t/*.t"
  }
);


my %FallbackPrereqs = (
  "Carp" => 0,
  "Config::Auto" => 0,
  "Data::Dumper" => 0,
  "Fcntl" => 0,
  "File::Basename" => 0,
  "File::Path" => 0,
  "Params::Validate" => 0,
  "Term::ReadKey" => 0,
  "Test::More" => 0,
  "Test::Warn" => 0,
  "Text::FormatTable" => 0,
  "strict" => 0,
  "warnings" => 0
);


unless ( eval { ExtUtils::MakeMaker->VERSION(6.63_03) } ) {
  delete $WriteMakefileArgs{TEST_REQUIRES};
  delete $WriteMakefileArgs{BUILD_REQUIRES};
  $WriteMakefileArgs{PREREQ_PM} = \%FallbackPrereqs;
}

delete $WriteMakefileArgs{CONFIGURE_REQUIRES}
  unless eval { ExtUtils::MakeMaker->VERSION(6.52) };

WriteMakefile(%WriteMakefileArgs);



