#
# = Define: php::mod::pear::mod
#
define php::mod::pear::mod (
  $package = undef,
  $version = undef,
) {

  $mod_name = $title

  include ::php

  $mod_pear_packages = $::php::mod_pear_packages
  $mod_pear_package  = $mod_pear_packages[$mod_name]

  # if package is not defined, generate package name
  if $package {
    $package_name = $package
  } elsif $mod_pear_package {
    $package_name = $mod_pear_package
  }

  # if version is not defined, use one from php
  if $version {
    $package_version = $version
  } else {
    $package_version = $::php::version
  }

  # finally create package
  package { "php-pear-${mod_name}" :
    ensure => $package_version,
    name   => $package_name,
    notify => $::php::notify,
    noop   => $::php::noops,
  }

}
