# Class: stdlib42
#
# stdlib42 is a module with common functions, defines and classes that
# are used by the Example42 Puppet Modules
#
# == Variables
#
# This class doesn't require variables.
# It doesn't provide resources but just sets these variables:
# $stdlib42::osname - The equivant of lsbdistcodename if you don't use
#                     lsb based facts
# $stdlib42::source - An abstracted source path for offloading
#                     the file server sitewide or managing pre 0.25 versions
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
# General settings for standard types
Exec { path => '/bin:/sbin:/usr/bin:/usr/sbin' }

#import "*.pp"

class stdlib42 {
# Some General Use Variables

# Calculate OS version (without using lsb facts)
    $ossplit=split($::operatingsystemrelease, '[.]')
    $osver=$ossplit[0]

# Set OS name (for Ubuntu and Debian without using lsbdistcodename
    $osname=$::operatingsystemrelease ? {
        /^4/       => 'etch',
        /^5/       => 'lenny',
        /^lenny/   => 'lenny',
        /^6/       => 'squeeze',
        /^squeeze/ => 'squeeze',
        '8.04'     => 'hardy',
        '8.10'     => 'intrepid',
        '9.04'     => 'jaunty',
        '9.10'     => 'karmic',
        '10.04'    => 'lucid',
        '10.10'    => 'meerkat',
        '11.04'    => 'natty',
        '11.10'    => 'oneiric',
        default    => 'unknown',
    }


## FILE SERVING SOURCE
# Sets the correct source for static files
# In order to provide files from different sources without modifying a module
# you can override the default source path setting the variable $base_source
# What follows automatically manages the source standard for Puppet
# versions pre and post 0.25
    case $::base_source {
        '': {
            $source = $::puppetversion ? {
                /(^0.25)/ => 'puppet:///modules',
                /(^0.)/   => "puppet://$::servername",
                default   => 'puppet:///modules',
            }
        }
        default: { $source=$::base_source }
    }
}
