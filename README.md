Qdrakeboo-Kubectl
======

> Docker image containing kubectl with certain plugins. Used in the Qdrakeboo deployment process.

[![Travis CI](https://img.shields.io/travis/bbortt/qdrakeboo-kubectl?style=for-the-badge)](https://travis-ci.com/bbortt/qdrakeboo-kubectl)
[![Release](https://img.shields.io/docker/pulls/qdrakeboo/kubectl?style=for-the-badge)](https://cloud.docker.com/repository/docker/qdrakeboo/kubectl)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg?style=for-the-badge)](https://opensource.org/licenses/MIT)

# Image contains
* [kubectl](https://github.com/kubernetes/kubectl) - The Kubernetes command-line tool, kubectl, allows you to run commands against Kubernetes clusters
* [kube-score](https://github.com/zegl/kube-score) - Kubernetes object analysis with recommendations for improved reliability and security
* [kubectl-vault_sync](https://github.com/postfinance/kubectl-vault_sync) - A plugin to sync Kubernetes secrets with [Hashicorp Vault](https://github.com/hashicorp/vault)
* [git-secrets](https://github.com/awslabs/git-secrets) - Prevents you from committing passwords and other sensitive information to a git repository
* [secrethub CLI])https://secrethub.io) - Secure, end-to-end encrypted secret storage

# Example usage
An example using GitHub Actions is available in [bbortt/qdrakeboo-deplyoment](https://github.com/bbortt/qdrakeboo-deployment).

# License
This project is licensed under the terms of the [MIT license](https://github.com/bbortt/qdrakeboo-kubectl/blob/master/LICENSE).
