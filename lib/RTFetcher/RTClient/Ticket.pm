package RTFetcher::RTClient::Ticket;

use strict;
use warnings;

use JSON;
use RT::Client::REST::Ticket;
use RTFetcher::Conf;
use RTFetcher::RTClient::Client;
use Data::Dumper;

my $rt = RTFetcher::RTClient::Client->new();
$rt->_get_client();
$rt->login();

sub _ticketClient {
    my( $rt ) = @_;
    #return RTFetcher::RTClient::Client->new(rt => $rt);
    return RT::Client::REST::Ticket->new( rt => $rt );
}

sub search_ticket_count_per_user {
    my( $filter ) = @_;

    print Dumper $filter;
    print Dumper $rt;

    my $ticket = _ticketClient($rt);

    print Dumper $filter;
=cut
    my $results = $ticket->search(
        limits => $filter->{filters},
        order_by => 'subject',
    );

        return $results->count;

#    } or do {
#        my $e = shift;
#        #print ref($e), ": ", $e->message;
#        return $e;
#    };

    #return $results->count;
#    return {
=cut
}

1;
