# Git Primer — Norfolk-Show Project

You'll use Git through the terminal (Command Prompt on Windows, Terminal on Mac/Linux).
Not the VS Code button. Not GitHub Desktop. The terminal.

Why? Because every Git tool in existence is just a wrapper around these commands.
Learn the commands once and every tool makes sense forever.

---

## One-time setup (do this once, ever)

Tell Git who you are. Use the email on your GitHub account.

    git config --global user.name "Your Name"
    git config --global user.email "you@example.com"

Check it worked:

    git config --global --list

---

## One-time setup per project

Get the project onto your computer ("clone" = download a copy):

    cd Documents          (or wherever you keep your projects)
    git clone https://github.com/RealGUppercut/Norfolk-Show.git
    cd Norfolk-Show

You now have a folder called `Norfolk-Show`. Open _this folder_ in Godot.

---

## How this project works

**You cannot push directly to `main`.** GitHub will reject it.

Everyone works on their own branch. When you're done, you open a pull request
(PR) — a request to merge your branch into `main`. Two teammates have to
approve it, and the build has to pass, before it gets merged.

This is how every real software team works. Get used to it now.

---

## The daily loop

### 1. Switch to main and pull the latest

Every session starts here. No exceptions.

	git checkout main
	git pull

This makes sure you're starting from the most up-to-date version everyone else
has merged.

### 2. Create your branch

Pick a short name describing what you're doing. Use hyphens, no spaces.

	git checkout -b feature/jump-animation

Good names:

- `feature/jump-animation`
- `feature/title-screen`
- `fix/enemy-collision-bug`
- `feature/sam-player-controller`

Bad names: `mybranch`, `stuff`, `test`, `branch1`

### 3. Do your work

Open Godot. Make your changes. Save.

### 4. See what you changed

	git status

### 5. Stage and commit

	git add .
	git commit -m "Added jump animation states to player"

Commit messages must describe what you did. Be specific.

You can commit as many times as you want before pushing. Commit small chunks
— it makes life easier if you need to undo something.

### 6. Push your branch

First time pushing this branch:

	git push -u origin feature/jump-animation

The `-u origin feature/jump-animation` tells Git "remember where this branch
lives". After the first push, you can just type:

	git push

### 7. Open a pull request

Go to https://github.com/RealGUppercut/Norfolk-Show

You'll see a yellow banner: "feature/jump-animation had recent pushes. Compare & pull request."

Click it. Write a short description of what you did. Click "Create pull request".

### 8. Wait for review

Two teammates have to approve it. The build (Actions tab) has to pass.

While you wait, **start a new branch for your next task** — see step 1.
Don't sit idle. Don't keep working on the branch under review.

If reviewers ask for changes:

1. Switch back to your branch: `git checkout feature/jump-animation`
2. Make the changes, commit, push.
3. The PR updates automatically.

### 9. Merge

Once approved + green build, click "Merge pull request" on GitHub.
Then click "Delete branch" — branches are disposable, kill them after merging.

### 10. Back to step 1

Switch to main, pull, branch off again for the next thing.

---

## The minimum command list

    git checkout main                       start of session
    git pull                                get latest
    git checkout -b feature/<thing>         new branch
    git status                              what changed
    git add .                               stage
    git commit -m "..."                     local save
    git push -u origin feature/<thing>      first push of branch
    git push                                subsequent pushes
    git checkout <branch-name>              jump to another branch
    git branch                              list your branches

---

## Reviewing someone else's PR

You'll be asked to review teammates' PRs. To do it properly:

1.  Go to the PR page on GitHub.
2.  Click "Files changed" — read what they changed.
3.  If you want to actually run their code:

		git fetch
		git checkout feature/their-branch-name

	Open Godot, test it.

4.  Back on the PR page, click "Review changes" (top right):
	- **Approve** if it works and looks good.
	- **Request changes** if something's broken or wrong.
    - **Comment** if you want to ask a question without blocking.

Don't rubber-stamp approve. If you don't understand what the PR does, ask
the author to explain in the PR comments. That's part of the point.

---

## When things go wrong

### "Updates were rejected because the remote contains work that you do not have"

Someone pushed to the same branch as you (rare, but happens on shared
branches). Fix:

	git pull

Then push again.

### "Merge conflict" on your PR

Someone merged something to main that touches the same code as you.
GitHub will show "This branch has conflicts that must be resolved".

Fix:

	git checkout main
	git pull
	git checkout feature/your-branch
	git merge main

Git will tell you which files have conflicts. Open each one — you'll see:

    <<<<<<< HEAD
    your version
    =======
    the version from main
    >>>>>>> main

Delete the markers, decide what the final version should be, save, then:

    git add .
    git commit          (no message needed)
    git push

**Prevention is better than cure: don't edit the same scene as a teammate.**

### "I'm on the wrong branch / I committed to main by accident"

Don't push. Ask the teacher. Easy to fix before pushing, hard after.

### "I want to throw away everything I've done on this branch"

    git checkout main
    git branch -D feature/the-doomed-branch

Then start fresh from step 2.

---

## Rules for this project

1. **Never work on `main`.** Always branch off it.
2. **Pull `main` at the start of every session.**
3. **One feature = one branch = one PR.** Don't pile unrelated changes into one PR.
4. **Small PRs get reviewed fast. Big PRs sit there for days.** Aim for under 200 lines changed.
5. **Never edit a scene a teammate is editing right now.** Coordinate verbally.
6. **Don't approve PRs you haven't read.**
7. **Don't touch:** `.github/`, `.gitignore`, `.gitattributes`, `export_presets.cfg`. These run the build. Breaking them breaks everyone's exports.

---

## How to check the build worked

After your PR is opened, the build runs automatically. You'll see a status
check on the PR. Green tick = ready to merge. Red X = click it, fix the
error, push again.

The live web version of the game is at:

    https://realguppercut.github.io/Norfolk-Show/

Updates ~1 minute after a PR is merged to main.
