#
# = Class: php::fpm
#
class php::fpm (
  $service             = $::php::params::fpm_service,
  $service_enable      = true,
  $service_ensure      = 'running',
  $file_owner          = $::php::params::file_owner,
  $file_group          = $::php::params::file_group,
  $file_mode           = $::php::params::file_mode,
  $pidfile             = '/var/run/php-fpm/php-fpm.pid',
  $phpfpmconf_file     = '/etc/php-fpm.conf',
  $phpfpmconf_template = 'php/php-fpm.conf.erb',
  $pool_dir            = $::php::params::fpm_pool_dir,
  $error_log           = '/var/log/php-fpm/error.log',
  $log_level           = 'notice',
  $process_max         = '128',
  $process_priority    = undef,
  $rlimit_files        = undef,
  $rlimit_core         = undef,
  $events_mechanism    = undef,
  $systemd_interval    = undef,
  $autoload_pools      = true,
) inherits php::params {

  include ::php

  File {
    ensure  => file,
    owner   => $file_owner,
    group   => $file_group,
    mode    => $file_mode,
    noop    => $::php::noops,
  }

  ::php::mod { 'fpm': }

  file { '/var/run/php-fpm':
    ensure => directory,
    path   => regsubst($pidfile, '^(.*)/.*', '\1', 'G'),
  }

  file { '/var/log/php-fpm':
    ensure => directory,
    path   => regsubst($error_log, '^(.*)/.*', '\1', 'G'),
    owner  => php-fpm,
    mode   => '0770',
  }

  file { '/etc/php-fpm.conf':
    path    => $phpfpmconf_file,
    content => template($phpfpmconf_template),
    require => Php::Mod['fpm'],
  }

  service { 'php-fpm':
    ensure  => $service_ensure,
    enable  => $service_enable,
    name    => $service,
    require => File['/etc/php-fpm.conf', '/var/run/php-fpm'],
  }

  # autoload configs from php::fpm::pools from hiera
  if ( $autoload_pools == true ) {
    $php_fpm_pools = hiera_hash('php::fpm::pools', {})
    create_resources(::Php::Fpm::Pool, $php_fpm_pools)
  }

}
