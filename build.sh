#!/bin/bash
# Build Execution environment
SOFTWARE="ansible-builder podman"

function sanity_check() {
   ok=1
   for prog in $SOFTWARE
   do
      which $prog > /dev/null || { echo "Missing program $prog."; ok=0; }
   done
   test $ok -ne 1 && { echo "Sanity check failed. Aboring." ; exit 1; }
}

sanity_check

ANSIBLE_VERSION=$(grep ansible-core execution-environment.yml | cut -d= -f3)
ansible-builder build -v3 -t ee-base-$ANSIBLE_VERSION:latest
