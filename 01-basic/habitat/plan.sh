pkg_name=01-basic
pkg_origin=mgamini
pkg_version="0.1.0"
pkg_maintainer="The Habitat Maintainers <humans@habitat.sh>"
pkg_license=("Apache-2.0")
# pkg_source="http://some_source_url/releases/${pkg_name}-${pkg_version}.tar.gz"
# pkg_filename="${pkg_name}-${pkg_version}.tar.gz"
# pkg_shasum="TODO"
pkg_deps=(core/node)
# pkg_build_deps=(core/make core/gcc)
# pkg_lib_dirs=(lib)
# pkg_include_dirs=(include)
# pkg_bin_dirs=(bin)
# pkg_pconfig_dirs=(lib/pconfig)
# pkg_svc_run="bin/haproxy -f $pkg_svc_config_path/haproxy.conf"
# pkg_exports=(
#   [host]=srv.address
#   [port]=srv.port
#   [ssl-port]=srv.ssl.port
# )
# pkg_exposes=(port ssl-port)
# pkg_binds=(
#   [srv]="port host"
# )
# pkg_binds_optional=(
#   [storage]="port host"
# )
# pkg_interpreters=(bin/bash)
# pkg_svc_user="hab"
# pkg_svc_group="$pkg_svc_user"
# pkg_description="Some description."
# pkg_upstream_url="http://example.com/project-name"

declare -A node_env

# Define path to config file
node_env[APP_CONFIG]="{{pkg.svc_config_path}}/config.json"

pkg_exports=( [port]=listening_port )
pkg_exposes=(port)

do_build() {
  # The mytutorialapp source code is in a relative directory, so you must copy the
  # contents of the source directory into your $CACHE_PATH as this
  # is the same path that Habitat would use if you downloaded a tarball of the source code.
  cp -vr $PLAN_CONTEXT/../app.js $CACHE_PATH
}

do_install() {
  # Our source files were copied over to $CACHE_PATH in do_build(),
  # and now they need to be copied from that directory into the root directory of our package
  # through the use of the pkg_prefix variable.
  cp $CACHE_PATH/app.js ${pkg_prefix}
}