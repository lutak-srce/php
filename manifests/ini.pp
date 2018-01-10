#
# = Define: php
#
# This define manages php.ini's
#
define php::ini (
  $owner,
  $group,
  $mode,
  $template,
  $dir_php_confd,
  $error_log,
  $ensure = file,
  $path   = $title,
  $notify = undef,
  $noops  = undef,
) {

  file { $title :
    ensure  => $ensure,
    path    => $path,
    owner   => $owner,
    group   => $group,
    mode    => $mode,
    content => template($template),
    notify  => $notify,
    noop    => $noops,
  }

}
