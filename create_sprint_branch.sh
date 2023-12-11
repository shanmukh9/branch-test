#!/bin/bash

# Function to check if a branch exists
branch_exists() {
    branch_name=$1
    if git show-ref --verify --quiet refs/heads/"$branch_name"; then
        return 0  # Branch exists
    else
        return 1  # Branch does not exist
    fi
}

# Define the sprint number
sprint_number="test_sprint_977"  # Replace "SprintX" with your actual sprint number

# Get the current date
current_date=$(date +"%Y%m%d")

# Check if 'main' and 'release' branches exist
if branch_exists "main" && branch_exists "release"; then
    if git log main..release &> /dev/null; then
        base_branch="main"
    else
        base_branch="release"
    fi
else
    if branch_exists "main"; then
        base_branch="main"
    elif branch_exists "release"; then
        base_branch="release"
    else
        echo "Error: Neither 'main' nor 'release' branches exist."
        exit 1
    fi
fi

# Create the branch name with sprint number and date
branch_name="${sprint_number}_${current_date}"

# Checkout the determined base branch
git checkout "$base_branch"

# Pull the latest changes from the base branch
git pull origin "$base_branch"

# Create a new branch from the base branch with the generated name
git checkout -b "$branch_name"

# Push the newly created branch to remote
git push origin "$branch_name"

# Optionally, set up tracking for the branch
git branch -u origin/"$branch_name"

echo "Sprint branch $branch_name created successfully from $base_branch branch!"
