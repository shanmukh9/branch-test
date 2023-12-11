import subprocess
from datetime import datetime

# Define the sprint number
sprint_number = "test_sprint_actions"  # Replace "SprintX" with your actual sprint number

# Get the current date
current_date = datetime.now().strftime("%Y%m%d")

# Check if main branch is behind release branch
git_log_output = subprocess.check_output("git log main..release", shell=True)
base_branch = "main" if git_log_output else "release"

# Create the branch name with sprint number and date
branch_name = f"{sprint_number}_{current_date}"

# Checkout the determined base branch
subprocess.run(f"git checkout {base_branch}", shell=True)

# Pull the latest changes from the base branch
subprocess.run(f"git pull origin {base_branch}", shell=True)

# Create a new branch from the base branch with the generated name
subprocess.run(f"git checkout -b {branch_name}", shell=True)

# Push the newly created branch to remote
subprocess.run(f"git push origin {branch_name}", shell=True)

# Optionally, set up tracking for the branch
subprocess.run(f"git branch -u origin/{branch_name}", shell=True)

print(f"Sprint branch {branch_name} created successfully from {base_branch} branch!")
