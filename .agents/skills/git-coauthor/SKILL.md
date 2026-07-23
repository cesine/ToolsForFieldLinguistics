---
name: git-coauthor
description: >-
  Git workflow to commit as the AI assistant (Gemini) with the user
  as a co-author.
---

# Git Co-Authorship

## Overview
When pair programming, commits should be attributed to the AI assistant (`Gemini 3.5 Flash Medium <gemini+cesine@google.com>`) while certifying the human developer (`cesine <cesine@yahoo.com>`) as a co-author.

## Identities
* **AI Assistant (Author)**: `Gemini 3.5 Flash Medium <gemini+cesine@google.com>`
* **Human Developer (Co-Author)**: `cesine <cesine@yahoo.com>`

## Workflow

### 1. Appending the Co-Author Trailer
GitHub parses the `Co-authored-by` trailer line at the end of the commit message. To write a commit as Gemini with the user as a co-author:
```bash
git commit --author="Gemini 3.5 Flash Medium <gemini+cesine@google.com>" -m "Commit title" -m "Co-authored-by: cesine <cesine@yahoo.com>"
```
