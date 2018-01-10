#
# = Define: php::mod::pecl::mod
#
define php::mod::pecl::mod (
  $package = undef,
  $version = undef,
) {

  $mod_name = $title

  include ::php

  $mod_pecl_packages = $::php::mod_pecl_packages
  $mod_pecl_package  = $mod_pecl_packages[$mod_name]

  # if package is not defined, generate package name
  if $package {
    $package_name = $package
  } elsif $mod_pecl_package {
    $package_name = $mod_pecl_package
  }

  # if version is not defined, use one from php
  if $version {
    $package_version = $version
  } else {
    $package_version = $::php::version
  }

  # finally create package
  package { "php-pecl-${mod_name}" :
    ensure => $package_version,
    name   => $package_name,
    notify => $::php::notify,
    noop   => $::php::noops,
  }

}
