# == Class role_bootstrap::params
#
# This class is meant to be called from role_bootstrap.
# It sets variables according to platform.
#
class role_bootstrap::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'role_bootstrap'
      $service_name = 'role_bootstrap'
    }
    'RedHat', 'Amazon': {
      $package_name = 'role_bootstrap'
      $service_name = 'role_bootstrap'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}
