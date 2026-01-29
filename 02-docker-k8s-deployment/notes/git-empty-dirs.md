# Git and empty directories

## Symptom
Created Project 2 directories, but `git commit` showed: "nothing to commit".

## Root cause
Git does not track empty directories. Only files are tracked.

## Fix
Add `.gitkeep` placeholder files to required directories, then commit.

## Commands
touch 02-docker-k8s-deployment/{app/docker,k8s,scripts,runbooks,notes}/.gitkeep
