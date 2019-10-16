package RTFetcher::RTClient::Client;

use strict;
use warnings;

use File::FindLib 'lib';

use Error qw(:try);
use RT::Client::REST;
use RTFetcher::Conf;
use RT::Client::REST::Ticket;
use Data::Dumper;

my $conf = RTFetcher::Conf->new();

sub new {
    my( $class ) = @_;
    return bless {}, $class;
}

sub _get_client {
    my( $self ) = @_;

    $self->{rt} = RT::Client::REST->new( server => $conf->{rt_host} );
    print Dumper $self;
    return $self->login();
}

sub _auth_client {
    my( $self ) = @_;

    return $self->{rt} = $self->{rt}->login( 
            username => $conf->{rt_user}, 
            password => $conf->{rt_password} 
        );
}

sub login {
    my ($self) = @_;

    return $self->_auth_client();
}

sub _ticketClient {
    my( $self ) = @_;

    return RT::Client::REST::Ticket->new( ticket => $self->{rt} );
}

sub search_ticket_count_per_user {
    my( $self, $filter ) = @_;

    print "\nINSIDE METHODDDDDDDDDDDDDD\n";

    my $client = $self->_get_client();
    my $ticket = $client->_ticketClient();
    print Dumper $ticket;
 
    my $results = $ticket->search(
        limits => $filter->{filters},
        order_by => 'subject',
    );

    print Dumper $results;
    return "Done";
}
