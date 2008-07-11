#!/usr/bin/perl -w
# If your copy of perl is not in /usr/bin, please adjust the line above.
#
# Copyright (C) 1998-2001 VMware, Inc.  All Rights Reserved.
#
# Tar package manager for VMware

use strict;
use diagnostics;

# Constants
my $cRegistryDir = '/etc/vmware';
my $cStateDir = $cRegistryDir . '/state';
my $cInstallerMainDB = $cRegistryDir . '/locations';
my $cInstallerObject = $cRegistryDir . '/installer.sh';
my $cConfFlag = $cRegistryDir . '/not_configured';

# BEGINNING OF THE SECOND LIBRARY FUNCTIONS
# Global variables
my %gDBAnswer;
my %gDBFile;
my %gDBDir;

# Load the installer database
sub db_load {
  undef %gDBAnswer;
  undef %gDBFile;
  undef %gDBDir;

  open(INSTALLDB, '<' . $cInstallerMainDB) or error('Unable to open the installer database ' . $cInstallerMainDB . ' in read-mode.' . "\n\n");
  while (<INSTALLDB>) {
    if (/^answer (\S+) (\S+)/) {
      $gDBAnswer{$1} = $2;
    } elsif (/^answer (\S+)/) {
      $gDBAnswer{$1} = '';
    } elsif (/^remove_answer (\S+)/) {
      delete $gDBAnswer{$1};
    } elsif (/^file (\S+) (\S+)/) {
      $gDBFile{$1} = $2;
    } elsif (/^file (\S+)/) {
      $gDBFile{$1} = 0;
    } elsif (/^remove_file (\S+)/) {
      delete $gDBFile{$1};
    } elsif (/^directory (\S+)/) {
      $gDBDir{$1} = '';
    }
  }
  close(INSTALLDB);
}

# Open the database on disk in append mode
sub db_append {
  if (not open(INSTALLDB, '>>' . $cInstallerMainDB)) {
    error('Unable to open the installer database ' . $cInstallerMainDB . ' in append-mode.' . "\n\n");
  }
  # Force a flush after every write operation.
  # See 'Programming Perl', p. 110
  select((select(INSTALLDB), $| = 1)[0]);
}

# Add a file to the tar installer database
# flags:
#  0x1 write time stamp
sub db_add_file {
  my $file = shift;
  my $flags = shift;

  if ($flags & 0x1) {
    my @statbuf;

    @statbuf = stat($file);
    if (not (defined($statbuf[9]))) {
      error('Unable to get the last modification timestamp of the destination file ' . $file . '.' . "\n\n");
    }

    $gDBFile{$file} = $statbuf[9];
    print INSTALLDB 'file ' . $file . ' ' . $statbuf[9] . "\n";
  } else {
    $gDBFile{$file} = 0;
    print INSTALLDB 'file ' . $file . "\n";
  }
}

# Remove a file from the tar installer database
sub db_remove_file {
  my $file = shift;

  print INSTALLDB 'remove_file ' . $file . "\n";
  delete $gDBFile{$file};
}

# Determine if a file belongs to the tar installer database
sub db_file_in {
  my $file = shift;

  return defined($gDBFile{$file});
}

# Return the timestamp of an installed file
sub db_file_ts {
  my $file = shift;

  return $gDBFile{$file};
}

# Add a directory to the tar installer database
sub db_add_dir {
  my $dir = shift;
  my $prefix;

  $gDBDir{$dir} = '';
  print INSTALLDB 'directory ' . $dir . "\n";
}

# Remove an answer from the tar installer database
sub db_remove_answer {
  my $id = shift;

  if (defined($gDBAnswer{$id})) {
    print INSTALLDB 'remove_answer ' . $id . "\n";
    delete $gDBAnswer{$id};
  }
}

# Add an answer to the tar installer database
sub db_add_answer {
  my $id = shift;
  my $value = shift;

  db_remove_answer($id);
  $gDBAnswer{$id} = $value;
  print INSTALLDB 'answer ' . $id . ' ' . $value . "\n";
}

# Retrieve an answer that must be present in the database
sub db_get_answer {
  my $id = shift;

  if (not defined($gDBAnswer{$id})) {
    error('Unable to find the answer ' . $id . ' in the installer database (' . $cInstallerMainDB . '). You may want to re-install VMware.' . "\n\n");
  }

  return $gDBAnswer{$id};
}

# Save the tar installer database
sub db_save {
  close(INSTALLDB);
}
# END OF THE SECOND LIBRARY FUNCTIONS

# BEGINNING OF THE LIBRARY FUNCTIONS
# Constants
my $cTerminalLineSize = 80;

# Global variables
my %gAnswerSize;
my %gCheckAnswerFct;

# Tell if the user is the super user
sub is_root {
  return $> == 0;
}

# Wordwrap system: append some content to the output
sub append_output {
  my $output = shift;
  my $pos = shift;
  my $append = shift;

  $output .= $append;
  $pos += length($append);
  if ($pos >= $cTerminalLineSize) {
    $output .= "\n";
    $pos = 0;
  }

  return ($output, $pos);
}

# Wordwrap system: deal with the next character
sub wrap_one_char {
  my $output = shift;
  my $pos = shift;
  my $word = shift;
  my $char = shift;
  my $reserved = shift;
  my $length;

  if (not (($char eq "\n") || ($char eq ' ') || ($char eq ''))) {
    $word .= $char;

    return ($output, $pos, $word);
  }

  # We found a separator. Process the last word

  $length = length($word) + $reserved;
  if (($pos + $length) > $cTerminalLineSize) {
    # The last word doesn't fit in the end of the line. Break the line before it
    $output .= "\n";
    $pos = 0;
  }
  ($output, $pos) = append_output($output, $pos, $word);
  $word = '';

  if ($char eq "\n") {
    $output .= "\n";
    $pos = 0;
  } elsif ($char eq ' ') {
    if ($pos) {
      ($output, $pos) = append_output($output, $pos, ' ');
    }
  }

  return ($output, $pos, $word);
}

# Wordwrap system: word-wrap a string plus some reserved trailing space
sub wrap {
  my $input = shift;
  my $reserved = shift;
  my $output;
  my $pos;
  my $word;
  my $i;

  $output = '';
  $pos = 0;
  $word = '';
  for ($i = 0; $i < length($input); $i++) {
    ($output, $pos, $word) = wrap_one_char($output, $pos, $word, substr($input, $i, 1), 0);
  }
  # Use an artifical last '' separator to process the last word
  ($output, $pos, $word) = wrap_one_char($output, $pos, $word, '', $reserved);

  return $output;
}

# Print an error message and exit
sub error {
  my $msg = shift;

  print STDERR wrap($msg . 'Execution aborted.' . "\n\n", 0);
  exit 1;
}

# Convert a string to its equivalent shell representation
sub shell_string {
  my $single_quoted = shift;

  $single_quoted =~ s/'/'"'"'/g;
  # This comment is a fix for emacs's broken syntax-highlighting code --hpreg
  return '\'' . $single_quoted . '\'';
}

# Contrary to a popular belief, 'which' is not always a shell builtin command.
# So we can not trust it to determine the location of other binaries.
# Moreover, SuSE 6.1's 'which' is unable to handle program names beginning with
# a '/'...
#
# Return value is the complete path if found, or '' if not found
sub internal_which {
  my $bin = shift;

  if (substr($bin, 0, 1) eq '/') {
    # Absolute name
    if ((-f $bin) && (-x $bin)) {
      return $bin;
    }
  } else {
    # Relative name
    my @paths;
    my $path;

    if (index($bin, '/') == -1) {
      # There is no other '/' in the name
      @paths = split(':', $ENV{'PATH'});
      foreach $path (@paths) {
	my $fullbin;

	$fullbin = $path . '/' . $bin;
	if ((-f $fullbin) && (-x $fullbin)) {
	  return $fullbin;
	}
      }
    }
  }

  return '';
}

# Remove leading and trailing whitespaces
sub remove_whitespaces {
  my $string = shift;

  $string =~ s/^\s*//;
  $string =~ s/\s*$//;
  return $string;
}

# Ask a question to the user and propose an optional default value
# Use this when you don't care about the validity of the answer
sub query {
    my $message = shift;
    my $defaultreply = shift;
    my $reserved = shift;
    my $reply;

    # Reserve some room for the reply
    print wrap($message . (($defaultreply eq '') ? '' : (' [' . $defaultreply . ']')), 1 + $reserved);
    # This is what the 1 is for
    print ' ';
	   
    chop($reply = <STDIN>);

    print "\n";
    $reply = remove_whitespaces($reply);
    if ($reply eq '') {
      $reply = $defaultreply;
    }
    return $reply;
}

# Check the validity of an answer whose type is yesno
# Return a clean answer if valid, or ''
sub check_answer_binpath {
  my $answer = shift;
  my $source = shift;

  if (not (internal_which($answer) eq '')) {
    return $answer;
  }

  if ($source eq 'user') {
    print wrap('The answer "' . $answer . '" is invalid. It must be the complete name of a binary file.' . "\n\n", 0);
  }
  return '';
}
$gAnswerSize{'binpath'} = 20;
$gCheckAnswerFct{'binpath'} = \&check_answer_binpath;

# Prompts the user if a binary is not found
# Return value is:
#  '': the binary has not been found
#  the binary name if it has been found
sub DoesBinaryExist_Prompt {
  my $bin = shift;
  my $answer;

  $answer = check_answer_binpath($bin, 'default');
  if (not ($answer eq '')) {
    return $answer;
  }

  if (get_answer('Setup is unable to find the "' . $bin . '" program on your machine. Please make sure it is installed. Do you want to specify the location of this program by hand?', 'yesno', 'yes') eq 'no') {
    return '';
  }

  return get_answer('What is the location of the "' . $bin . '" program on your machine?', 'binpath', '');
}

# chmod() that reports errors
sub safe_chmod {
  my $mode = shift;
  my $file = shift;

  if (chmod($mode, $file) != 1) {
    error('Unable to change the access rights of the file ' . $file . '.' . "\n\n");
  }
}

# Emulate a simplified ls program for directories
sub internal_ls {
  my $dir = shift;
  my @fn;

  opendir(LS, $dir);
  @fn = grep(!/^\.\.?$/, readdir(LS));
  closedir(LS);

  return @fn;
}

# Install a file permission
sub install_permission {
  my $src = shift;
  my $dst = shift;
  my @statbuf;

  @statbuf = stat($src);
  if (not (defined($statbuf[2]))) {
    error('Unable to get the access rights of the source file ' . $src . '.' . "\n\n");
  }
  safe_chmod($statbuf[2] & 0xFFF, $dst);
}

# Emulate a simplified sed program
# Return 1 if success, 0 if failure
sub internal_sed {
  my $src = shift;
  my $dst = shift;
  my $append = shift;
  my $patchRef = shift;
  my @patchKeys;

  if (not open(SRC, '<' . $src)) {
    return 0;
  }
  if (not open(DST, (($append == 1) ? '>>' : '>') . $dst)) {
    return 0;
  }

  @patchKeys = keys(%$patchRef);
  if ($#patchKeys == -1) {
    while(defined($_ = <SRC>)) {
      print DST $_;
    }
  } else {
    while(defined($_ = <SRC>)) {
      my $patchKey;

      foreach $patchKey (@patchKeys) {
	s/$patchKey/$$patchRef{$patchKey}/g;
      }

      print DST $_;
    }
  }

  close(SRC);
  close(DST);
  return 1;
}

# Check if a file name exists
sub file_name_exist {
  my $file = shift;

  # Note: We must test for -l before, because if an existing symlink points to
  #       a non-existing file, -e will be false
  return ((-l $file) || (-e $file))
}

# Check if a file name already exists and prompt the user
# Return 0 if the file can be written safely, 1 otherwise
sub file_check_exist {
  my $file = shift;

  if (not file_name_exist($file)) {
    return 0;
  }

  # The default must make sure that the product will be correctly installed
  # We give the user the choice so that a sysadmin can perform a normal
  # install on a NFS server and then answer 'no' NFS clients
  return (get_answer('The file ' . $file . ' that this script was about to install already exists. Overwrite?', 'yesno', 'yes') eq 'yes') ? 0 : 1;
}

# Install one file
# flags are forwarded to db_add_file()
sub install_file {
  my $src = shift;
  my $dst = shift;
  my $patchRef = shift;
  my $flags = shift;

  uninstall_file($dst);
  if (file_check_exist($dst)) {
    return;
  }
  # The file could be a symlink to another location. Remove it
  unlink($dst);
  if (not internal_sed($src, $dst, 0, $patchRef)) {
    error('Unable to copy the source file ' . $src . ' to the destination file ' . $dst . '.' . "\n\n");
  }
  db_add_file($dst, $flags);
  install_permission($src, $dst);
}

# mkdir() that reports errors
sub safe_mkdir {
  my $file = shift;

  if (mkdir($file, 0000) == 0) {
    error('Unable to create the directory ' . $file . '.' . "\n\n");
  }
}

# Remove trailing slashes in a dir path
sub dir_remove_trailing_slashes {
  my $path = shift;

  for(;;) {
    my $len;
    my $pos;

    $len = length($path);
    if ($len < 2) {
      # Could be '/' or any other character. Ok.
      return $path;
    }

    $pos = rindex($path, '/');
    if ($pos != $len - 1) {
      # No trailing slash
      return $path;
    }

    # Remove the trailing slash
    $path = substr($path, 0, $len - 1)
  }
}

# Emulate a simplified dirname program
sub internal_dirname {
  my $path = shift;
  my $pos;

  $path = dir_remove_trailing_slashes($path);

  $pos = rindex($path, '/');
  if ($pos == -1) {
    # No slash
    return '.';
  }

  if ($pos == 0) {
    # The only slash is at the beginning
    return '/';
  }

  return substr($path, 0, $pos);
}

# Create a hierarchy of directories with permission 0755
# flags:
#  0x1 write this directory creation in the installer database
# Return 1 if the directory existed before
sub create_dir {
  my $dir = shift;
  my $flags = shift;

  if (-d $dir) {
    return 1;
  }

  if (index($dir, '/') != -1) {
    create_dir(internal_dirname($dir), $flags);
  }
  safe_mkdir($dir);
  if ($flags & 0x1) {
    db_add_dir($dir);
  }
  safe_chmod(0755, $dir);
  return 0;
}

# Get a valid non-persistent answer to a question
# Use this when the answer shouldn't be stored in the database
sub get_answer {
  my $msg = shift;
  my $type = shift;
  my $default = shift;
  my $answer;

  if (not defined($gAnswerSize{$type})) {
    die 'get_answer(): type ' . $type . ' not implemented :(' . "\n\n";
  }
  for (;;) {
    $answer = check_answer(query($msg, $default, $gAnswerSize{$type}), $type, 'user');
    if (not ($answer eq '')) {
      return $answer;
    }
  }
}

# Get a valid persistent answer to a question
# Use this when you want an answer to be stored in the database
sub get_persistent_answer {
  my $msg = shift;
  my $id = shift;
  my $type = shift;
  my $default = shift;
  my $answer;

  if (defined($gDBAnswer{$id})) {
    # There is a previous answer in the database
    $answer = check_answer($gDBAnswer{$id}, $type, 'db');
    if (not ($answer eq '')) {
      # The previous answer is valid. Make it the default value
      $default = $answer;
    }
  }

  $answer = get_answer($msg, $type, $default);
  db_add_answer($id, $answer);
  return $answer;
}

# Find a suitable backup name and backup a file
sub backup_file {
  my $file = shift;
  my $i;

  for ($i = 0; $i < 100; $i++) {
    if (not file_name_exist($file . '.old.' . $i)) {
      my %patch;

      undef %patch;
      if (internal_sed($file, $file . '.old.' . $i, 0, \%patch)) {
	print wrap('File ' . $file . ' is backed up to ' . $file . '.old.' . $i . '.' . "\n\n", 0);
      } else {
	print STDERR wrap('Unable to backup the file ' . $file . ' to ' . $file . '.old.' . $i .'.' . "\n\n", 0);
      }
      return;
    }
  }

  print STDERR wrap('Unable to backup the file ' . $file . '. You have too many backups files. They are files of the form ' . $file . '.old.N, where N is a number. Please delete some of them.' . "\n\n", 0);
}

# Uninstall a file previously installed by us
sub uninstall_file {
  my $file = shift;

  if (not db_file_in($file)) {
    # Not installed by this script
    return;
  }

  if (file_name_exist($file)) {
    if (db_file_ts($file)) {
      my @statbuf;

      @statbuf = stat($file);
      if (defined($statbuf[9])) {
	if (db_file_ts($file) != $statbuf[9]) {
	  # Modified since this script installed it
	  backup_file($file);
	}
      } else {
	print STDERR wrap('Unable to get the last modification timestamp of the file ' . $file . '.' . "\n\n", 0);
      }
    }

    if (not unlink($file)) {
      print STDERR wrap('Unable to remove the file ' . $file . '.' . "\n\n", 0);
    }
  } else {
    print wrap('This script previously created the file ' . $file . ', and was about to remove it. Somebody else apparently did it already.' . "\n\n", 0);
  }

  db_remove_file($file);
}

# Check the validity of an answer whose type is yesno
# Return a clean answer if valid, or ''
sub check_answer_yesno {
  my $answer = shift;
  my $source = shift;

  if (lc($answer) =~ /^y(es)?$/) {
    return 'yes';
  }

  if (lc($answer) =~ /^n(o)?$/) {
    return 'no';
  }

  if ($source eq 'user') {
    print wrap('The answer "' . $answer . '" is invalid. It must be one of "y" or "n".' . "\n\n", 0);
  }
  return '';
}
$gAnswerSize{'yesno'} = 3;
$gCheckAnswerFct{'yesno'} = \&check_answer_yesno;

# Check the validity of an answer based on its type
# Return a clean answer if valid, or ''
sub check_answer {
  my $answer = shift;
  my $type = shift;
  my $source = shift;

  if (not defined($gCheckAnswerFct{$type})) {
    die 'check_answer(): type ' . $type . ' not implemented :(' . "\n\n";
  }
  return &{$gCheckAnswerFct{$type}}($answer, $source);
}
# END OF THE LIBRARY FUNCTIONS

# BEGINNING_OF_TMPDIR_DOT_PL
#!/usr/bin/perl

use strict;

# Create a temporary directory
#
# They are a lot of small utility programs to create temporary files in a
# secure way, but none of them is standard. So I wrote this --hpreg
sub make_tmp_dir {
  my $prefix = shift;
  my $tmp;
  my $serial;
  my $loop;

  $tmp = defined($ENV{'TMPDIR'}) ? $ENV{'TMPDIR'} : '/tmp';

  # Don't overwrite existing user data
  # -> Create a directory with a name that didn't exist before
  #
  # This may never succeed (if we are racing with a malicious process), but at
  # least it is secure
  $serial = 0;
  for (;;) {
    # Check the validity of the temporary directory. We do this in the loop
    # because it can change over time
    if (not (-d $tmp)) {
      error('"' . $tmp . '" is not a directory.' . "\n\n");
    }
    if (not ((-w $tmp) && (-x $tmp))) {
      error('"' . $tmp . '" should be writable and executable.' . "\n\n");
    }

    # Be secure
    # -> Don't give write access to other users (so that they can not use this
    # directory to launch a symlink attack)
    if (mkdir($tmp . '/' . $prefix . $serial, 0755)) {
      last;
    }

    $serial++;
    if ($serial % 200 == 0) {
      print STDERR 'Warning: The "' . $tmp . '" directory may be under attack.' . "\n\n";
    }
  }

  return $tmp . '/' . $prefix . $serial;
}

# END_OF_TMPDIR_DOT_PL

# Check the validity of an answer whose type is dirpath
# Return a clean answer if valid, or ''
sub check_answer_dirpath {
  my $answer = shift;
  my $source = shift;

  $answer = dir_remove_trailing_slashes($answer);

  if (-d $answer) {
    # The path is an existing directory
    return $answer;
  }

  # The path is not a directory
  if (file_name_exist($answer)) {
    if ($source eq 'user') {
      print wrap('The path "' . $answer . '" exists, but is not a directory.' . "\n\n", 0);
    }
    return '';
  }

  # The path does not exist
  if ($source eq 'user') {
    return (get_answer('The path "' . $answer . '" does not exist currently. This script is going to create it, including needed parent directories. Is this what you want?', 'yesno', 'yes') eq 'yes') ? $answer : '';
  } else {
    return $answer;
  }
}
$gAnswerSize{'dirpath'} = 20;
$gCheckAnswerFct{'dirpath'} = \&check_answer_dirpath;

# Check the validity of an answer whose type is initdirpath
# Return a clean answer if valid, or ''
sub check_answer_initdirpath {
  my $answer = shift;
  my $source = shift;
  my $testdir;

  $answer = dir_remove_trailing_slashes($answer);

  if (not (-d $answer)) {
    if ($source eq 'user') {
      print wrap('The path "' . $answer . '" is not an existing directory.' . "\n\n", 0);
    }
    return '';
  }

  foreach $testdir ('init.d', 'rc0.d',  'rc1.d', 'rc2.d', 'rc3.d', 'rc4.d', 'rc5.d', 'rc6.d') {
    if (not (-d $answer . '/' . $testdir)) {
      if ($source eq 'user') {
	print wrap('The path "' . $answer . '" is a directory which does not contain a ' . $testdir . ' directory.' . "\n\n", 0);
      }
      return '';
    }
  }

  return $answer;
}
$gAnswerSize{'initdirpath'} = 15;
$gCheckAnswerFct{'initdirpath'} = \&check_answer_initdirpath;

sub exec_command {
  my $pid;
  
  error('Fork failed while trying to execute '.$_[0].'.'."\n\n") unless defined($pid = open(KID, "-|"));
  if ($pid) {
    my $answer;
    $answer = '';
    while (<KID>) {
      chomp;
      $answer .= $_;
    }
    close KID;
    return $answer;
  } else {
    { exec @_; }
    print "?\n";
    exit 0;
  }
}

# We know only 2 products: ws and wgs... and if it is wgs, fine, otherwise it is ws...
# We may want to recognize tools here too, but they live in different directory...
sub get_product {
   my $prod = 'ws';

   if (open INP, '<'.$cInstallerObject) {
      my $line;

      while (defined($line = <INP>)) {
         chomp $line;
	 if ($line =~ /^vmware_product/) {
	    $line = <INP>;
	    if (defined($line) and $line =~ /echo\s+\'?([a-z]+)/) {
	       $prod = $1;
	    }
         }
      }
      close INP;
   }
   return $prod;
}

sub update_vmware_config_pl {
   my $modified = 0;
   my $seen_patched = 0;
   my $file = db_get_answer('BINDIR') . '/vmware-config.pl';
   print "Updating $file ... ";
   if (open(INPUT, '<'.$file)) {
      my $line;
      my @config = ();
      my $last_is_answer = 0;
      my $uts_replacement = '"#include <linux/version.h>".(-f $answer."/linux/utsrelease.h" ? "\n#include <linux/utsrelease.h>" : "")';
      my $uts_replacement_re = $uts_replacement;
      $uts_replacement_re =~ s/([.?$()\\])/\\$1/g;
      while (defined($line = <INPUT>)) {
         chomp $line;

      	 if ($line =~ /^Categories=Application;System;$/) {
	    $line = 'Categories=Emulator;';
	    $modified = 1;
	 } elsif ($line =~ /^Categories=Emulator;$/) {
	    $seen_patched = 1;
	 }
         if ($line =~ /^\s*\.\s*shell_string\('#include <linux\/version\.h>'\s*\.\s*"\\n"\s*\./) {
	    # Old, not patched
            $line =~ s/^(\s*\.\s*shell_string\()'#include <linux\/version\.h>'/$1$uts_replacement/;
	    $modified = 1;
         } elsif ($line =~ /^\s*\.\s*shell_string\($uts_replacement_re/) {
	    # Old, patched
	    $seen_patched = 1;
	 } elsif ($line =~ /^\s*\.\s*shell_string\(\$uts_headers/) {
	    # New, fixed
	 } elsif ($line =~ /^\s*return\s*\$answer;/) {
	    $last_is_answer = 1;
	 } elsif ($line =~ /^\s*\$header_page_offset\s*=\s*direct_command/) {
	    if ($last_is_answer) {
	       $last_is_answer = 0;
	       $seen_patched = 1;
	    } else {
	       push @config, '  return $answer;'."\n";
	       $modified = 1;
	    }
	 } else {
	    $last_is_answer = 0;
	 }
	 push @config, $line."\n";
      }
      close INPUT;
      if ($modified) {
         if (open(OUTPUT, '>'.$file)) {
	    print OUTPUT join('', @config);
	    close OUTPUT;
	 } else {
	    $modified = 0;
	    $seen_patched = 0;
	 }
      }
   }
   if ($modified) {
      if ($seen_patched) {
         print "partially patched, now fully patched\n";
      } else {
         print "now patched\n";
      }
   } elsif ($seen_patched) {
      print "already patched\n";
   } else {
      print "corrupted\n";
   }
}

# Install the content of the tar package
sub install_content {
  my $answer;
  my %patch;
  my $version;
  my $vmmon_source;

  $version = exec_command($cInstallerObject, 'version');
  if ($version ne '2' and $version ne '3' and $version ne '4') {
    error('Unknown VMware version '.$version.' is installed. This installer supports only version 2 and 3.'."\n\n");
  }
  if ($version < 4) {
    update_vmware_config_pl();
  }
  $answer = db_get_answer('LIBDIR');
  undef %patch;
  install_file('./vmmon.tar', $answer . '/modules/source/vmmon.tar', \%patch, 0x1);
  install_file('./vmnet.tar', $answer . '/modules/source/vmnet.tar', \%patch, 0x1);
  if ($version >= 4) {
    install_file('./vmblock.tar', $answer . '/modules/source/vmblock.tar', \%patch, 0x1);
  }
  
  if ($version < 4) {
    my $prod = get_product();
    if ($prod eq 'wgs') {
      %patch = ('%SHORTNAME%' => 'wgs',
                '%LONGNAME%'  => 'VMware GSX Server' );
    } elsif ($prod eq 'vserver') {
      %patch = ('%SHORTNAME%' => 'wgs',  # Cheat a bit to get simpler services.sh
                '%LONGNAME%'  => 'VMware Server' );
    } else {
       %patch = ('%SHORTNAME%' => $prod,
                 '%LONGNAME%'  => 'VMware Workstation' );
    }
    $patch{'%PACKAGERVERSION%'} = $version;

    $answer = db_get_answer('INITSCRIPTSDIR');
    install_file('./services.sh', $answer . '/vmware', \%patch, 0x1);
  }
  system('./update vmware   "' . db_get_answer('BINDIR') . '/vmware"');
  system('./update bridge   "' . db_get_answer('BINDIR') . '/vmnet-bridge"');
  system('./update vmx      "' . db_get_answer('LIBDIR') . '/bin/vmware-vmx"');
  system('./update vmxdebug "' . db_get_answer('LIBDIR') . '/bin-debug/vmware-vmx"');
}

# Program entry point
sub main {
  my $answer;

  if (not is_root()) {
    error('Please re-run this script as the super user.' . "\n\n");
  }

  # Force the path to reduce the risk of using "modified" external helpers
  # If the user has a special system setup, he will will prompted for the
  # proper location anyway
  $ENV{'PATH'} = '/bin:/usr/bin:/sbin:/usr/sbin';

  db_load();
  db_append();
  install_content();
  print wrap('VMware modules in "'. db_get_answer('LIBDIR') . '/modules/source" has been updated.' . "\n\n", 0);
  $answer = get_persistent_answer('Before running VMware for the first time after update, you need to configure it for your running kernel by invoking the following command: "' . db_get_answer('BINDIR') . '/vmware-config.pl". Do you want this script to invoke the command for you now?', 'RUN_CONFIGURATOR', 'yesno', 'yes');
  db_save();
  if ($answer eq 'yes') {
    system(shell_string(db_get_answer('BINDIR') . '/vmware-config.pl'));
  } else {
    print wrap('Enjoy,' . "\n\n" . '    --the VMware team' . "\n\n", 0);
  }
}

main();
