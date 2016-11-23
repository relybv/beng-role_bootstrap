# == Class role_bootstrap::config
#
# This class is called from role_bootstrap for service config.
#
class role_bootstrap::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

}
