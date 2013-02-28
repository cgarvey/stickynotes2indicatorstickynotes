A script to convert the older Sticky Notes Gnome app format to the newer Indicator Sticky Notes format.

INFO
====
When I upgraded from [Ubuntu](http://www.ubuntu.com/ "Link to Ubuntu Linux website") 10.04 to 12.04, I found there was no easy way to keep my
old "Post-it&trade;" sticky notes.

When Ubuntu introduced [Unity](http://unity.ubuntu.com/ "Link to Ubuntu's Unity microsite") in version 11.04,
[Gnome](http://www.gnome.org/ "Link to Gnome website") applets were no longer available (without some effort). With the change
went [StickyNotes](http://help.gnome.org/users/stickynotes_applet/stable/stickynotes-introduction.html.en "Link to manual explaining use of StickyNotes")
which I had used a lot.

[Indicator StickyNotes](https://launchpad.net/indicator-stickynotes "Link to Indicator StickyNotes project") came to the rescue (similar
functionality and a clickable icon in the "indicator" area to show/hide the notes). However, there is no easy way to import
the notes from the old StickyNotes app (a completely different app).

This script will read the configuration file of the older app (an XML format) and output to a file
suitable for use in the newer app (a JSON format). It assumes you still have access to a copy of
your old StickyNotes configuration file (default location was ` ~/.gnome2/stickynotes_applet`).

It outputs to the specified destination which can be the default location of the
Indicator StickyNotes configuration file (by default in `~/.config/indicator-stickynotes`), or
to any other destination for testing.

In this project's early state, **I recommend you backup both app's configuration files before using this script**.


USAGE
=====
`convert_stickynotes.pl` <*stickynotes_file*> <*indicator_stickynotes_file*>

<***stickynotes_file***> The path to the old StickyNotes applet config file.
This is required, and must be readable. This script does not
alter the file. E.g. ~/.gnome2/stickynotes_applet

<***indicator_stickynotes_file***> The path to the new Indicator StickyNotes
config file. This script will add notes to this file, so you
should BACKUP beforehand. E.g. ~/.config/indicator-stickynotes 

Prerequisites
-------------
This PERL script requires PERL be installed, obviously, and for the modules [XML::Simple](http://search.cpan.org/~grantm/XML-Simple-2.20/lib/XML/Simple.pm "Link to PERL module on CPAN") & [JSON](http://search.cpan.org/~makamaka/JSON-2.53/lib/JSON.pm "Link to PERL module on CPAN") to be available.

Sample Use
----------
* *Assuming the two configuration files are in their default location (which is probably not the case, unless you've upgrade Ubuntu)*
* Download the convert_stickynotes.pl script
* Quit Indicator StickyNotes if it is already running
* Make a backup of your original StickyNotes config file, and your current Indicator StickyNotes config files.

	``cp ~/.gnome2/stickynotes_applet ~/my-oldstickynotes``

	``cp ~/.config/indicator-stickynotes ~/my-newindicatorstickynotes``
* Run the script (don't overwrite your backups from the previous step!)

	`./convert_stickynotes.pl ~/.gnome2/stickynotes_applet ~/.config/indicator-stickynotes`

* Launch Indicator StickyNotes again.

SUPPORT
=======
Support is not provided with this script. However, if you open an issue, I'll endeavour to help you out if I can.

LICENCE
=======
**Copyright 2012 Cathal Garvey. http://cgarvey.ie/**

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance with the License. You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.

*(Free) commercial licensing available on request.*


