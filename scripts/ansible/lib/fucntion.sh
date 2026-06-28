#!/bin/bash
#####################################################################
#
# Copyright (c) 2022-present, Birchi (https://github.com/Birchi)
# All rights reserved.
#
# This source code is licensed under the MIT license.
#
#####################################################################
function detect_os() {
    os="LINUX"
    case "$(uname -s)" in
        "Darwin") os="MacOS" ;;
    esac
    echo ${os}
}

function get_log_level() {
    case $1 in
        ERROR) echo 1 ;;
        WARN) echo 2 ;;
        INFO) echo 3 ;;
        DEBUG) echo 4 ;;
    esac
}

function log() {
    log_level=${1}
    log_message=$2
    if [[ $(get_log_level ${LOG_LEVEL:-INFO}) -ge $(get_log_level $log_level) ]] ; then
        if [[ "$(detect_os)" == "MacOS" ]] ; then
            echo -e "$(date +"%Y-%m-%d %H:%M:%S") ${log_level}\t $log_message"
        else
            echo -e "$(date +"%Y-%m-%d %H:%M:%S.%3N") ${log_level}\t $log_message"
        fi
    fi
}

function validation_error() {
    echo $1
    exit 1
}

function error() {
    log ERROR "$1"
    exit 1
}

