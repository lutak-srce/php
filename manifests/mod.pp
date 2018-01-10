#
# = Define: php::mod
#
define php::mod (
  $package = undef,
  $version = undef,
) {

  $mod_name = $title

  include ::php

  $mod_packages = $::php::mod_packages
  $mod_package  = $mod_packages[$mod_name]

  # if package is not defined, generate package name
  if ( $package ) {
    $package_name = $package
  } elsif $mod_package {
    $package_name = $mod_package
  }

  # if version is not defined, use one from php
  if ( $version ) {
    $package_version = $version
  } else {
    $package_version = $::php::version
  }

  # finally create package
  package { "php-${mod_name}" :
    ensure => $package_version,
    name   => $package_name,
    notify => $::php::notify,
    noop   => $::php::noops,
  }

}
