#!/usr/bin/perl

use strict;
use warnings;

use WWW::Curl::Easy;
use XML::Simple;

die "Usage: $0 <username> <gpg file>\n" unless scalar @ARGV == 2;

my $gmail_url = "https://mail.google.com/mail/feed/atom";
my $user = $ARGV[0];
my $pw_path = $ARGV[1];

# Get password
open my $fh, '-|', "gpg -q --decrypt $pw_path"
    or die "Could not find encrypted password file.";
my $pw = <$fh>;

# Do some curling
my $curl = WWW::Curl::Easy->new;

my $response;
$curl->setopt(CURLOPT_WRITEDATA,\$response);
$curl->setopt(CURLOPT_URL, $gmail_url);
$curl->setopt(CURLOPT_USERPWD, "$user:$pw");
$curl->perform;

my $xml = XML::Simple->new();
my $data = $xml->XMLin($response);

my $new_mails = $data->{fullcount};

printf "Mail: %d", $new_mails;
