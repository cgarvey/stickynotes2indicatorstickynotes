#! /usr/bin/perl

#  Copyright 2013 Cathal Garvey. http://cgarvey.ie/
#
#  Licensed under the Apache License, Version 2.0 (the "License");
#  you may not use this file except in compliance with the License.
#  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing, software
#  distributed under the License is distributed on an "AS IS" BASIS,
#  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#  See the License for the specific language governing permissions and
#  limitations under the License.

use strict;

eval {
	require XML::Simple;
	require JSON;
};
if( $@ ) {
	print "This script depends on the following Perl modules which could not\nbe detected:\n\tXML::Simple\n\tJSON\n";
}
else {
	if( $#ARGV == 1 ) {
		if( -r( $ARGV[0] ) ) {
			my( $xmlParser ) = new XML::Simple( KeepRoot => 1, ForceArray => [ 'note' ] );
			my( $data ) = $xmlParser->XMLin( $ARGV[0] );

			if( $data->{stickynotes} && $data->{stickynotes}{version} ne "" ) {
				if( ( 0 + substr( $data->{stickynotes}{version}, 0 ) ) >= 2 ) {
					if( $data->{stickynotes}{note} ) {
						my( $iCount ) = ( 1 + $#{ $data->{stickynotes}{note} } );
						if( $iCount > 0 ) {
							print "Processing " . $iCount . " note(s)...\n";

							my( @arrNotes ) = ();
							my( $i );
							for( $i = 0; $i < $iCount; $i++ ) {
								my( $noteData ) = $data->{stickynotes}{note}[$i];

								if( $noteData ) {
									my( %hNote ) = ();
									$hNote{'cat'} = "";
									$hNote{'body'} = $noteData->{'content'};
									#$hNote{'uuid'} = ""; #Gets created by Indicator StickyNotes on first run anyway, so no need to generate UUID here.
									my( $sLocked ) = \0;
									if( $noteData->{'locked'} eq "true" ) { $sLocked = \1; }

									$hNote{'properties'} = {
										"size" => [ ( 0 + $noteData->{'w'} ), ( 0 + $noteData->{'h'} ) ],
										"position" => [ ( 0 + $noteData->{'x'} ), ( 0 + $noteData->{'y'} ) ],
										"locked" => $sLocked,
									};

									@arrNotes = ( @arrNotes, \%hNote );
								}
							}

							my( %hData ) = ();
							$hData{ "notes" } = \@arrNotes;

							my( $json ) = JSON->new->allow_nonref;

							open( F, ">:utf8", $ARGV[1] ) or die "Could not write to the Indicator StickyNotes file specified.\n";
							print F $json->encode( \%hData );
							close( F );

							print "...done\n\n";
						}
					}
				}
				else {
					print "Unsupported version! This script has not been tested with your older version of\n";
					print "StickyNotes Gnome Appplet. Contact the authore (raise an issue on Github, with\n";
					print "details of your config file, for further assistance.\n";
				}
			}
			else {
				print "Invalid format detected in the specified StickyNotes config file.\n";
				print "Are you sure you're using the expected config file (a StickyNotes\n";
				print "Gnome Applet used in Ubuntu <= 10.10)?\n";
			}
			
		}
		else {
			die( "Could not read the StickyNotes applet config file specified.\n" );
		}
	}
	else {
		print "Insufficient arguments specified.\n";
		&printUsage();
	}
}

exit;

sub printUsage {
	print << "EOP"

INFO
====
Convert the old configuration file format of StickyNotes Gnome applet
(Ubuntu <= 10.10) to a format used by Indicator StickyNotes, a Unity-compatible
app for more recent Ubuntu versions.

USAGE
=====
convert_stickynotes.pl <stickynotes_file> <indicator_stickynotes_file>
	<stickynotes_file> The path to the old StickyNotes applet config file.
		This is required, and must be readable. This script does not
		alter the file. E.g. ~/.gnome2/stickynotes_applet
	<indicator_stickynotes_file> The path to the new Indicator StickyNotes
		config file. This script will add notes to this file, so you
		should BACKUP beforehand. E.g. ~/.config/indicator-stickynotes

EOP
}

