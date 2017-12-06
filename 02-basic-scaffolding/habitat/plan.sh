pkg_name=02-basic-scaffolding
pkg_origin=mgamini
pkg_version="0.1.0"
pkg_scaffolding="core/scaffolding-node"


declare -A scaffolding_env

# Define path to config file
scaffolding_env[APP_CONFIG]="{{pkg.svc_config_path}}/config.json"