#!/bin/bash

# Copyright (c) Facebook, Inc. and its affiliates.
#
# This source code is licensed under the MIT license found in the
# LICENSE file in the root directory of this source tree.

sledge=$PWD/cli/sledge_cli.exe

export SLEDGE_CONFIG=$PWD/../../test/config

line=$(\
  $sledge help -recursive -expand \
    | grep -n "== subcommands ===" \
    | cut -d : -f1,1)

line=$(($line+1))

$sledge help -recursive | sed -e "s/sledge_cli.exe/sledge/g"

$sledge h -r -e \
  | tail -n +$line \
  | sed -e "s/  \(.*\)  .*/\1/g;/^ *$/d" \
  | while read cmd; do \
      printf "\n====== sledge $cmd ======\n\n"; \
      $sledge $cmd -help | sed -e "s/sledge_cli.exe/sledge/g"; \
    done
