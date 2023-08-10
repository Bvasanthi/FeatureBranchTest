#!/bin/bash
 
REPO=https://bhggit/projects/SFE/repos/bhg-salesforce-dx
BITBUCKET_API=https://api.bitbucket.org/2.0/repositories/$REPO
 
# Fetch latest branches
git fetch
 
# Get all branches that start with "Feature-"
branches=$(git branch -r | grep 'Feature-' | sed 's/origin\///g')
 
for branch in $branches
do
# Get the date of the last commit on the branch in ISO 8601 format
commit_date=$(git show -s --format=%ci $branch)
 
# Convert it to seconds since epoch
commit_date_epoch=$(date --date="$commit_date" +%s)
 
# Get the current date in seconds since epoch
current_date_epoch=$(date +%s)
 
# Calculate the difference in months
month_old=$(( ( $current_date_epoch - $commit_date_epoch ) / 60 / 60 / 24 / 30 ))
 
if (( $month_old > 1 )); then
# The branch is older than 1 month, delete it
echo "Deleting $branch..."
                                                                         
# Delete the branch locally
git branch -d $branch
 
# Delete the branch remotely
#git push origin --delete $branch
fi
done
