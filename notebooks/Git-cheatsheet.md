# Git Bash Command Cheat Sheet (for Regular Use)

A practical reference for working with Git and GitHub via Git Bash, tailored for solo project development and regular daily workflows.

### Navigate to your project folder (adjust the path if needed):

```bash
cd /your/path
```

### Clone the GitHub Repository

This creates a local folder named repo-name that is connected to your GitHub repository.

```bash
git clone https://github.com/yourusername/repo-name.git
```

### If starting a new Git project:

```bash
git init                         # Initialize Git in the current folder
git remote add origin <repo-url> # Link local repo to GitHub
```

### To pull the latest changes from GitHub:

```bash
git pull origin main              # Update local repo with GitHub's main branch
```

### To check the status of files:

```bash
git status                        # Show changed, staged, and untracked files
```

### To stage files for commit:

```bash
git add .                         # Stage all changes in the folder
git add filename.ext              # Stage a specific file
```

### To commit changes with a message:

```bash
git commit -m "Describe what you changed"
```

### To push your committed changes to GitHub:

```bash
git push origin main              # Push commits to GitHub's main branch
```

### To view history and changes:

```bash
git log                           # View full commit history
git log --oneline                 # Short, one-line-per-commit view
git diff                          # See unstaged changes
git diff --cached                 # See staged (to-be-committed) changes
```

### Working with branches (if needed):

```bash
git branch                        # List all local branches
git checkout -b new-branch        # Create and switch to a new branch
git checkout main                 # Switch back to the main branch
git merge branch-name             # Merge another branch into the current one
```

### Helpful clean-up and rescue commands:

```bash
git stash                         # Save current changes without committing
git stash pop                     # Restore stashed changes
git merge --abort                 # Cancel a merge if conflicts arise
git branch -d branch-name         # Delete a local branch
git push origin --delete branch-name  # Delete a branch from GitHub
```

### Merging Unrelated Histories (Troubleshooting)
Use this when your local project and the GitHub repo weren't originally connected (e.g., local `git init`, then link to an existing GitHub repo):

```bash
git pull origin main --allow-unrelated-histories
```

### Daily workflow summary:

```bash
cd /path/to/project               # Go to your repo folder
git pull origin main              # Sync with GitHub
# Make changes in your files
git status                        # Check what’s changed
git add .                         # Stage all changes
git commit -m "Your message"      # Commit with message
git push origin main              # Push to GitHub
```
