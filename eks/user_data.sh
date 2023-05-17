#!/bin/bash
set -o xtrace
/etc/eks/bootstrap.sh eks-cluster --kubelet-extra-args --node-labels=node.group=eks-cluster-nodegroup,spot=true