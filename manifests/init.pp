#
# Class: php
#
# This module manages php installation
#
class php (
  $ensure                = $::php::params::ensure,
  $package               = $::php::params::package,
  $version               = $::php::params::version,
  $timezone              = $::timezone,
  $file_mode             = $::php::params::file_mode,
  $file_owner            = $::php::params::file_owner,
  $file_group            = $::php::params::file_group,
  $file_php_ini          = $::php::params::file_php_ini,
  $template_php_ini      = $::php::params::template_php_ini,
  $dir_php_confd         = $::php::params::dir_php_confd,
  $error_log             = $::php::params::php_error_log,
  $file_php_cli_ini      = $::php::params::file_php_cli_ini,
  $template_php_cli_ini  = $::php::params::template_php_cli_ini,
  $dir_php_cli_confd     = $::php::params::dir_php_cli_confd,
  $cli_error_log         = $::php::params::php_cli_error_log,
  $notify_res            = undef,
  $mod_packages          = $::php::params::mod_packages,
  $mod_pecl_packages     = $::php::params::mod_pecl_packages,
  $mod_pear_packages     = $::php::params::mod_pear_packages,
  $dependency_class      = $::php::params::dependency_class,
  $my_class              = $::php::params::my_class,
  $noops                 = undef,
) inherits php::params {

  ### Internal variables (that map class parameters)
  if $ensure == 'present' {
    $package_ensure = $version ? {
      ''      => 'present',
      default => $version,
    }
    $file_ensure = present
  } else {
    $package_ensure = absent
    $file_ensure    = absent
  }

  ### Extra classes
  if $dependency_class { include $dependency_class }
  if $my_class         { include $my_class         }

  ### Code
  package { 'php':
    ensure => $package_ensure,
    name   => $package,
    notify => $notify_res,
    noop   => $noops,
  }

  ::php::mod{ 'common': }
  ::php::mod{ 'cli':    }

  ::php::ini { '/etc/php.ini':
    ensure        => $file_ensure,
    path          => $file_php_ini,
    owner         => $file_owner,
    group         => $file_group,
    mode          => $file_mode,
    template      => $template_php_ini,
    dir_php_confd => $dir_php_confd,
    error_log     => $error_log,
    require       => Php::Mod['common'],
    notify_res    => $notify_res,
    noop          => $noops,
  }

  ::php::ini { '/etc/php-cli.ini':
    ensure        => $file_ensure,
    path          => $file_php_cli_ini,
    owner         => $file_owner,
    group         => $file_group,
    mode          => $file_mode,
    template      => $template_php_cli_ini,
    dir_php_confd => $dir_php_cli_confd,
    error_log     => $cli_error_log,
    notify_res    => $notify_res,
    noop          => $noops,
    require       => Php::Mod['cli'],
  }

  file { '/etc/php.d/timezone.ini':
    ensure  => $file_ensure,
    path    => "${dir_php_confd}/timezone.ini",
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    content => template('php/timezone.ini.erb'),
    require => Package['php-common'],
    notify  => $notify_res,
    noop    => $noops,
  }

}
