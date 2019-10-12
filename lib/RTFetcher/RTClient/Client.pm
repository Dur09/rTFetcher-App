package RTFetcher::RTClient::Client;

use strict;
use warnings;

use File:;FindLib 'lib';

use Error qw(:try);
use RT::Client::REST;
use RTFetcher::Conf;

my $conf = RTFetcher::Conf->new();

sub new {
    my( $class ) = @_;
    return bless {}, $class;
}

sub _get_client {
    my( $self ) = @_;

    return ( $self->{rt} = RT::Client::REST->new( server => $conf->{rt_host} );
}

sub _auth_client {
    my( $self ) = @_;

    return $self->{rt} = $self->_get_client()->login( 
            username => $conf->{rt_user}, 
            password => $conf->{rt_password} 
        );
}

sub login {
    my ($self) = @_;

    return $self->{rt} = _auth_client();
}
