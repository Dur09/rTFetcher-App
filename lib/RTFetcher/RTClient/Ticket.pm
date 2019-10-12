package RTFetcher::RTClient::Ticket;

use strict;
use warnings;

use RT::Client::REST::Ticket;
use RTFetcher::Conf;
use RTFetcher::RTClient::Client;

my $rt = RTFetcher::RTClient::Client->new();

sub _ticketClient {
    my( $rt ) = @_;
    return RTFetcher::RTClient::Client->new(rt => $rt);
}

sub search_ticket_count_per_user {
    my( $rt, $filter, $order_by ) = @_;

    my $ticket = _ticketClient($rt);

    eval {
        my $results = $ticket->search(
            limits => @$filter,
            order_by => $order_by || 'subject',
        );

    } or die {
        my $e = shift;
        print ref($e), ": ", $e->message;
        return $e->message;
    };

    return $results->count;
}

1;

