# -*- perl -*-
#
# Module::TestConfig::Question - question interface
#
# $Id: Question.pm,v 1.4 2003/08/20 19:24:32 jkeroes Exp $

package Module::TestConfig::Question;

require 5.005_62;
use strict;
use Carp;

#------------------------------------------------------------
# Methods
#------------------------------------------------------------

sub new {
    my $proto = shift;
    my $class = ref $proto || $proto;
    my $self = bless {}, $class;
    $self->init( @_ );
}


sub init {
    my $self = shift;

    if ( ref $_[0] eq "ARRAY" ) {
	@{$self}{ qw/msg name default opts/ } = @{$_[0]};
    } else {
	my %args = ref $_[0] eq "HASH" ? %{$_[0]} : @_;
	while ( my ( $method, $args ) = each %args ) {
	    if ( $self->can( $method ) ) {
		$self->$method( $args );
	    } else {
		croak "Can't handle arg: '$method'. Aborting";
	    }
	}
    }

    return $self;
}

sub msg {
    my $self = shift;
    $self->{msg} = shift if @_;
    return $self->{msg};
}

sub name {
    my $self = shift;
    $self->{name} = shift if @_;
    $self->{name};
}

sub def {
    my $self = shift;
    $self->{default} = shift if @_;
    $self->{default};
}

sub opts {
    my $self = shift;

    if ( @_ ) {
	my %args = ref $_[0] eq "HASH" ? %{ $_[0] } : @_;

	while ( my ( $method, $args ) = each %args ) {
	    if ( $self->can( $method ) ) {
		$self->$method( $args );
	    } else {
		croak "Can't handle opts arg: '$method'. Aborting";
	    }
	}
    }

    return wantarray ? %{ $self->{opts} } : $self->{opts};
}

sub skip {
    my $self = shift;
    $self->{opts}{skip} = shift if @_;
    return $self->{opts}{skip};
}

sub validate {
    my $self = shift;
    $self->{opts}{validate} = shift if @_;
    return $self->{opts}{validate};
}

sub noecho {
    my $self = shift;
    $self->{opts}{noecho} = shift if @_;
    return $self->{opts}{noecho};
}

# Aliases
*default  = \&def;
*question = \&msg;
*options  = \&opts;

1;

=head1 NAME

Module::TestConfig::Question - question interface

=head1 SYNOPSIS

  use Module::TestConfig::Question;

  my $question = Module::TestConfig::Question->new(
	name => 'toes',
	msg => 'How many toes do you have?',
	def => 10,
	opts => {
		 noecho   => 0,
		 validate => { ... },
		 skip     => sub { ... },
		}
  );

=head1 PUBLIC METHODS

=over 2

=item new()

Args: See L<"SYNOPSIS">

Returns: an object

=item msg()

Required. The question we ask of a user. A string. Tends
to look best when there's a '?' or a ':' on the end.

Aliased as question()

Args: a question to ask the user

Returns: that question

=item name()

The name an answer is saved as. Basically a hash key.

Args: the question's name

Returns: that name

=item def()

A question's default answer.

Aliased as default().

Args: a default

Returns: that default

=item opts()

See L<"skip()">, L<"validate()"> and L<"noecho()">.

Aliased as options().

Args: A hash or hashref of options.

Returns: the hashref in scalar context, a hash in list context.

=item skip()

Criteria used to skip the current question. Either a scalar or
a coderef. If either evalutes to true, the current question
ought to be skipped.

Args: a scalar or coderef

Returns: the current scalar or coderef

=item validate()

Args to be passed directly to Params::Validate::validate() or another
validation subroutine.

Args: a hashref by default

Returns: the current hashref

=item noecho()

Do we echo the user's typing?

Args: 1 or 0

Returns: the current value

=back

=head1 AUTHOR

Joshua Keroes E<lt>jkeroes@eli.netE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2003 by Joshua Keroes E<lt>jkeroes@eli.netE<gt>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=head1 SEE ALSO

L<Module::TestConfig>

=cut
