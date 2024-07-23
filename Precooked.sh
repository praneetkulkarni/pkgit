#!/bin/sh

# Read input from standard input which provides the refs and SHAs
while read local_ref local_sha remote_ref remote_sha
do
  # Get branch name
  branch_name=$(git rev-parse --abbrev-ref $local_ref)

  # Get list of commits to be pushed
  if [ "$remote_sha" = "0000000000000000000000000000000000000000" ]; then
    # New branch, get all commits
    commit_list=$(git rev-list $local_sha)
  else
    # Existing branch, get only new commits
    commit_list=$(git rev-list $remote_sha..$local_sha)
  fi

  for commit in $commit_list
  do
    # Get commit details
    timestamp=$(git show -s --format=%ci $commit)
    user=$(git show -s --format=%cn $commit)
    
    # Log commit details
    echo "Commit: $commit"
    echo "Timestamp: $timestamp"
    echo "User: $user"
    echo "Branch: $branch_name"
    echo "---"
    # Add your logging or processing logic here
  done
done
