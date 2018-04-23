use strict;
my @modules = ('List::MoreUtils', 'Getopt::Long', 'MIME::Base64', 'Statistics::TTest',
                  'Text::NSP::Measures::2D::Fisher::twotailed', 
                  'Statistics::Multtest', 'File::Which');
my @requiredVersions = (0.33, 2.38, 3.08, 1.1, 0.97, 0.13, 1.09);
my %versionHASH;
my %installedVersionHASH;
my @uninstalledModules;
my @oldModules;
my $numRequired = @modules;
print "... CHECKING INSTALLED MODULES ...\n";
print "------------------------------------------------------------\n";
print "-- INSTALLED MODULES:\n";

for(my $i = 0; $i < $numRequired; $i++) { 
   $versionHASH{$modules[$i]} = $requiredVersions[$i];
}

foreach my $module ( @modules ) { 
   eval "require $module";
   if($@) { 
      push(@uninstalledModules, $module);
   }
   else {
      if($module->VERSION < $versionHASH{$module}) { 
         push(@oldModules, $module);
      }
      printf("-- %-50s: %s\n", $module, $module->VERSION);
      $installedVersionHASH{$module} = $module->VERSION;
   }
}
print "------------------------------------------------------------\n";

my $numUninstalled = @uninstalledModules;
if($numUninstalled > 0) { 
   print "=======================================================================\n";
   print "********* MISSING MODULES: PLEASE INSTALL BEFORE PROCEEDING ***********\n";
   print "cpanm is recommended: \n";
   print "(see: http://search.cpan.org/~miyagawa/Menlo-1.9003/script/cpanm-menlo)\n";
   print "   cpanm Module::Name\n\n";
   print "Missing Module List:\n";

   for(my $i = 0; $i < $numUninstalled; $i++) { 
      print "$uninstalledModules[$i]\t(Reqired version: $versionHASH{$uninstalledModules[$i]})\n";
   }
   print "======================================================================\n";
}

my $numOld = @oldModules;
if($numOld > 0) { 
   print "=======================================================================\n";
   print "********* OUTDATED MODULES: PLEASE INSTALL BEFORE PROCEEDING **********\n";
   print "cpanm is recommended: \n";
   print "(see: http://search.cpan.org/~miyagawa/Menlo-1.9003/script/cpanm-menlo)\n";
   print "   cpanm Module::Name\n\n";
   print "Old Module List:\n";
   printf ("%-50s %10s %10s\n", "Module Name", "Installed", "Required");
   for(my $i = 0; $i < $numOld; $i++) { 
      my $module = $oldModules[$i];
      printf("-- %-50s   %5.3lf    %5.3lf\n", $module, $installedVersionHASH{$module},
             $versionHASH{$module});
   }
   print "=======================================================================\n";
}
if(($numUninstalled > 0) || ($numOld > 0)) { 
   print "**** ERROR ****\n$numUninstalled modules missing; $numOld modules outdated\n";
   print "Please see list above and correct before proceeding\n";
   my $errorVal = $numUninstalled;
   exit($errorVal);
}
else {
   print "**** OK ****\nAll perl modules installed and up-to-date\n";
   exit(0);
}


