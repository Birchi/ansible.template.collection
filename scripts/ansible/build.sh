#!/bin/bash
#####################################################################
#
# Copyright (c) 2022-present, Birchi (https://github.com/Birchi)
# All rights reserved.
#
# This source code is licensed under the MIT license.
#
#####################################################################
# Load config and functions
. $(dirname $0)/cfg/config.sh
. $(dirname $0)/lib/function.sh


##
# Functions
##
function usage() {
    cat << EOF
This script builds an ansible collection according the collection folder.

Parameters:
  -c, --collection-directory     Sets the path of the output file path. Default value is '${collection_directory}'.
  -f, --output-directory     Sets the path of the output file path. Default value is '${output_directory}'.

Examples:
  $(dirname $0)/build.sh -c ${collection_directory} -f "${output_directory}"
  $(dirname $0)/build.sh --collection-directory ${collection_directory} --output-directory "${output_directory}"
EOF
}

function parse_cmd_args() {
    args=$(getopt --options f: \
                  --longoptions output-directory:,collection-directory: -- "$@")

    if [[ $? -ne 0 ]]; then
        echo "Failed to parse arguments!" && usage
        exit 1;
    fi

    while test $# -ge 1 ; do
        case "$1" in
            -h | --help) usage && exit 0 ;;
            -c | --collection-directory) collection_directory="$(eval echo $2)" ; shift 1 ;;
            -f | --output-directory) output_directory="$(eval echo $2)" ; shift 1 ;;
            --) ;;
             *) ;;
        esac
        shift 1
    done 
}

##
# Main
##

parse_cmd_args "$@"

readme_path=${collection_directory}/README.md
license_path=${collection_directory}/LICENSE
galaxy_yml_path=${collection_directory}/galaxy.yml

if ! [ -f ${galaxy_yml_path} ] ; then
    error "Missing galaxy.yml in collection."
fi

namespace_name=$(get_namespace ${galaxy_yml_path})
collection_name=$(get_collection ${galaxy_yml_path})

if ! [ -f ${readme_path} ] ; then
    log WARN "Missing README.md in collection."
fi

if ! [ -f ${license_path} ] ; then
    log INFO "Copying LICENSE to  ${license_path}"
    cp LICENSE ${license_path}
    log DEBUG "Copied LICENSE to  ${license_path}"
fi

if [ -d ${readme_path} ] ; then
    rm -rf ${output_directory}
fi

log INFO "Building ansible galaxy collection ${namespace_name}.${collection_name}."
cd ${collection_directory} && ansible-galaxy collection build --force --output-path ../${output_directory} > /dev/null 2>&1
log DEBUG "Built ansible galaxy collection ${namespace_name}.${collection_name}."
