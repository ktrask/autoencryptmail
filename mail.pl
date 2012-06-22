#!/usr/bin/perl
#(c) 2012 by ktrask
#3-clause BSD license, see LICENSE.md for further information

my $encryptKey = 'name@example.com';
my $sendmailPath = '/usr/sbin/sendmail';
#my $sendmailPath = 'cat;echo --';#for debugging


use Email::Simple;
use Crypt::GPG;
my $gpg = new Crypt::GPG;

my $args = join(" ",@ARGV); #prepare the arguments for sendmail
#print $args;

my $mailtext="";

until(eof(STDIN)) { #get the whole message
	        $mailtext .= <STDIN>;
}

#print $mailtext;
my $email = Email::Simple->new($mailtext);

my $encrypt = $email->header("X-Please-Encrypt");
if($encrypt ne "") {
	#print STDERR "encrypting...\n";
	my $mailbody = $email->body;
	my @encrypted = $gpg->encrypt ($mailbody, $encryptKey);
	$email->body_set($encrypted[0]);
}
else {
	#print STDERR "no encryption\n";
}

$mailtext = $email->as_string;
open SEND, "|$sendmailPath $args" || die "can't open sendmail: $!";
print SEND $mailtext;
close SEND;
