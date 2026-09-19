---
name: hunk-review
description: Review a changeset through a live Hunk session - narrate the diff in the user's terminal, steer their view to what matters, and leave inline comments. Use when the user has Hunk running, asks to review or walk through a diff with Hunk, or invokes /hunk-review.
---

# Hunk Review

Load the Hunk skill and use it for this review.

1. Run `hunk skill path` to get the skill path.
2. Read the file at that path.
3. Follow its instructions for the rest of this review.

The skill ships with the `hunk` binary and its path is version-pinned, so
resolve it at review time rather than caching or symlinking a copy.

If `hunk skill path` fails, `hunk` is not installed - say so instead of
guessing at `hunk session` commands.
