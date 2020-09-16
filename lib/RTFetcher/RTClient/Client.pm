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
    #my( $class ) = @_;
    #return bless {}, $class;
    my $class = shift;
    my $self = {};

    return bless($self, $class);
}

sub _get_client {
    my( $self ) = @_;

    $self->{rt} = RT::Client::REST->new( server => $conf->{rt_host} );
    return $self->_auth_client();
}

sub _auth_client {
    my( $self ) = @_;

    return $self->{rt}->login(
            username => $conf->{rt_user}, 
            password => $conf->{rt_pass} 
        );
}

# Currently the login() method is not used.
sub login {
    my ($self) = @_;

    return $self->_auth_client();
}

sub _ticketClient {
    my( $self ) = @_;

    return $self->{ticket} = RT::Client::REST::Ticket->new( rt => $self->{rt} );
}

sub search_ticket_count_per_user {
    my( $self, $filter ) = @_;

    my $client = $self->_get_client();
    my $ticket = $self->_ticketClient();
 
    my $results = $ticket->search(
        limits => $filter->{filters},
        order_by => 'subject',
    );

    my $resp;
    my @tickets;
    my $count = $results->count;
    my $iterator = $results->get_iterator;

    while (my $ticket = &$iterator) {
        $resp = {};
        $resp->{id} = $ticket->id;
        $resp->{sev} = $ticket->cf('severity');
        $resp->{desc} = $ticket->subject;
        $resp->{ts} = $ticket->created;
        push( @tickets, $resp );
    }
 
    return \@tickets;
}
