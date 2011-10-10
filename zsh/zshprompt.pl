#!/usr/bin/perl -w 

#requires Gtk-Perl

use Gtk;
use strict;

set_locale Gtk;
init Gtk;

my $window = new Gtk::Window("toplevel");
$window->signal_connect( "delete_event", \&CloseAppWindow );  
my $table = new Gtk::Table( 20, 6, 0 );
$window->border_width( 5 );
#$window->add( $button );


my $prompt = new Gtk::Entry( 128);
my $log = new Gtk::Text();
$log->set_usize(40,60);
$log->show();
$prompt->show();
#$prompt->set_editable (1);
$prompt->set_text("");
$table->attach( $prompt,0,4,0,4,[ 'expand', 'shrink', 'fill' ],
		'shrink',
		0, 0 ); 

$table->set_row_spacings( 5 ); 
$table->set_col_spacings( 5 ); 

my $currDir = new Gtk::Button( "Current Directory" );
$currDir->show();
$table->attach_defaults( $currDir,0,1,4,6 );

my $errorCode = new Gtk::Button( "Last Return Code" );
$errorCode->show();
$table->attach_defaults( $errorCode,1,2,4,6 );

my $currTime = new Gtk::Button( "Time" );
$currTime->show();
$table->attach_defaults( $currTime,2,3,4,6 );

my $hist = new Gtk::Button( "History Number" );
$hist->show();
$table->attach_defaults( $hist,3,4,4,6 );

my $host = new Gtk::Button( "Hostname" );
$host->show();
$table->attach_defaults( $host,0,1,6,8 );



my $backgroundBlue = new Gtk::Button( "Blue Background" );
$backgroundBlue->show();
$table->attach_defaults( $backgroundBlue,0,1,8,10 );

my $backgroundRed = new Gtk::Button( "Red Background" );
$backgroundRed->show();
$table->attach_defaults( $backgroundRed,1,2,8,10 );

my $backgroundGreen = new Gtk::Button( "Green Background" );
$backgroundGreen->show();
$table->attach_defaults( $backgroundGreen,2,3,8,10 );

my $backgroundYellow = new Gtk::Button( "Yellow Background" );
$backgroundYellow->show();
$table->attach_defaults( $backgroundYellow,3,4,8,10 );

my $backgroundBlack = new Gtk::Button( "Black Background" );
$backgroundBlack->show();
$table->attach_defaults( $backgroundBlack,5,6,8,10 );

my $backgroundWhite = new Gtk::Button( "White Background" );
$backgroundWhite->show();
$table->attach_defaults( $backgroundWhite,6,7,8,10 );

my $backgroundPink = new Gtk::Button( "Pink Background" );
$backgroundPink->show();
$table->attach_defaults( $backgroundPink,7,8,8,10 );





my $textBlue = new Gtk::Button( "Blue Text" );
$textBlue->show();
$table->attach_defaults( $textBlue,0,1,10,12 );

my $textRed = new Gtk::Button( "Red Text" );
$textRed->show();
$table->attach_defaults( $textRed,1,2,10,12 );

my $textGreen = new Gtk::Button( "Green Text" );
$textGreen->show();
$table->attach_defaults( $textGreen,2,3,10,12 );

my $textYellow = new Gtk::Button( "Yellow Text" );
$textYellow->show();
$table->attach_defaults( $textYellow,3,4,10,12 );

my $textBlack = new Gtk::Button( "Black Text" );
$textBlack->show();
$table->attach_defaults( $textBlack,5,6,10,12 );

my $textWhite = new Gtk::Button( "White Text" );
$textWhite->show();
$table->attach_defaults( $textWhite,6,7,10,12 );

my $textPink = new Gtk::Button( "Pink Text" );
$textPink->show();
$table->attach_defaults( $textPink,7,8,10,12 );


my $textDefault = new Gtk::Button( "Default Text" );
$textDefault->show();
$table->attach_defaults( $textDefault,0,1,12,14 );

my $backgroundDefault = new Gtk::Button( "Default Background" );
$backgroundDefault->show();
$table->attach_defaults( $backgroundDefault,1,2,12,14 );



my $set = new Gtk::Button( "Save Settings" );
$set->show();
$table->attach_defaults( $set,0,1,16,18 );

my $xterm = new Gtk::Button( "Test saved settings" );
$xterm->show();
$table->attach_defaults( $xterm,1,2,16,18 );

$table->attach_defaults( $log,0,6,18,20 );


$currDir->signal_connect( "clicked", \&insertButtonText, "%1/" );
$errorCode->signal_connect( "clicked", \&insertButtonText, "%?" );
$currTime->signal_connect( "clicked", \&insertButtonText, "%T" );
$hist->signal_connect( "clicked", \&insertButtonText, "%!" );
$host->signal_connect( "clicked", \&insertButtonText, "%m" );

$backgroundBlue->signal_connect( "clicked", \&insertButtonText, "%{\$bg[blue]%}" );
$backgroundRed->signal_connect( "clicked", \&insertButtonText, "%{\$bg[red]%}" );
$backgroundGreen->signal_connect( "clicked", \&insertButtonText, "%{\$bg[green]%}" );
$backgroundYellow->signal_connect( "clicked", \&insertButtonText, "%{\$bg[yellow]%}" );
$backgroundBlack->signal_connect( "clicked", \&insertButtonText, "%{\$bg[black]%}" );
$backgroundWhite->signal_connect( "clicked", \&insertButtonText, "%{\$bg[white]%}" );
$backgroundPink->signal_connect( "clicked", \&insertButtonText, "%{\$bg[magenta]%}" );
$backgroundDefault->signal_connect( "clicked", \&insertButtonText, "%{\$bg[default]%}" );




$textBlue->signal_connect( "clicked", \&insertButtonText, "%{\$fg[blue]%}" );
$textRed->signal_connect( "clicked", \&insertButtonText, "%{\$fg[red]%}" );
$textGreen->signal_connect( "clicked", \&insertButtonText, "%{\$fg[green]%}" );
$textYellow->signal_connect( "clicked", \&insertButtonText, "%{\$fg[yellow]%}" );
$textBlack->signal_connect( "clicked", \&insertButtonText, "%{\$fg[black]%}" );
$textWhite->signal_connect( "clicked", \&insertButtonText, "%{\$fg[white]%}" );
$textPink->signal_connect( "clicked", \&insertButtonText, "%{\$fg[magenta]%}" );
$textDefault->signal_connect( "clicked", \&insertButtonText, "%{\$fg[default]%}" );





$set->signal_connect( "clicked", \&pushEnv );
$xterm->signal_connect( "clicked", \&xterm );

sub xterm
{
my $string="xterm -e zsh -li&";
#$string.=$prompt->get_text();

#$string.="' zsh -li\"& ";

system($string);
# $prompt->append_text( $string );
$log->insert( "", "white", "black", "executing:\n $string\n");
}


sub pushEnv
{
chdir("~");
use Env qw(PS1);
my $pNotSet=0;
open(PROMPT, "+<", ".prompt") or $pNotSet=1;


if($pNotSet)
{
    #$prompt->insert( "", "white", "black", "prompt is not set");
    open(ZSHRC, '>>','.zshrc') or die "cannot open zshrc";
    print ZSHRC ". ~/.prompt\n";
    close (ZSHRC);
}
close (PROMPT);
open(PROMPT, ">", ".prompt");
print PROMPT "export PS1=\"",$prompt->get_text(),"\"\n";

#$prompt->insert( "", "white", "black", $PS1);

close(PROMPT);
close(ZSHRC);
$prompt->grab_focus();

}
$prompt->can_default(1);
$prompt->grab_default();
$table->show();
$window->add( $table );




$window->show();
$prompt->grab_focus();
main Gtk;

exit( 0 );

sub CloseAppWindow
{
   Gtk->exit( 0 );
   return 0;
}


sub insertButtonText 
{
    my ($widget, $txt) = @_;
 $prompt->append_text( $txt );
$prompt->grab_focus();
}
