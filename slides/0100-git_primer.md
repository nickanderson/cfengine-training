# Git Primer

.fx: titleslide

---
## Git
Git is the most popular modern version control management tool.
[Github](https://github.com), [Bitbucket](https://bitbucket.org), and
[GitLab](https://gitlab.com) all provide great hosted and on prem repository
management solutions.

Using a git management system is reccomended for implementing access controls
and improved collaboration with regard to policy and systems management.

## presenter notes

CFEngine Enterprise tooling works with git out of the box. If you don't want to use git the tooling is easily customized to support any version control system.

---
## Getting started
Log into the policy server

    !shell
    [user@workstation] $ vagrant ssh hub
    [vagrant@hub] $ sudo -i

Configure git author

    !shell
    [root@hub masterfiles] # git config -–global user.name “Mr. Slate”
    [root@hub masterfiles] # git config -–global user.email “bossman@slateco.com”
    [root@hub masterfiles] # git config --global push.default simple

---
## Clone builtin repository

    !shell
    [root@hub masterfiles] # git clone /opt/cfengine/masterfiles.git /vagrant/masterfiles
    Cloning into '/vagrant/masterfiles'...

## presenter notes
When an Enterprise hub is installed, a git repository is seeded with the stock
Masterfiles Policy Framework for that release. It provides an easy place to
play around with git and get setarted.

---
##  Add a file to the repository
    !shell
    [root@hub masterfiles] # cd /vagrant/masterfiles
    [root@hub masterfiles] # ls
    cfe_internal  Changelog  controls  def.cf  lessons  lib  libraries  promises.cf  services  sketches  update  update.cf
    [root@hub masterfiles] # echo hi > file
    [root@hub masterfiles] # git status
    # On branch master
    # Untracked files:
    #   (use "git add <file>..." to include in what will be committed)
    #
    #	file
    nothing added to commit but untracked files present (use "git add" to track)

---
## Stage and commit the changes
    !shell
    [root@hub masterfiles] # git add file
    [root@hub masterfiles] # git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	new file:   file
    #
    # git commit -m “Testing git workflow”
    [master c886caf] Testing git workflow
     0 files changed, 0 insertions(+), 0 deletions(-)
     create mode 100644 file

---
## Publish the change
    !shell
    [root@hub masterfiles] # git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    #
    nothing to commit (working directory clean)
    [root@hub masterfiles] # git push
    Counting objects: 4, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (3/3), 280 bytes, done.
    Total 3 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (3/3), done.
    To /opt/cfengine/masterfiles.git
       ee31801..94b8151  master -> master
    # git status
    # On branch master
    nothing to commit (working directory clean)

---
## Modify a file
    !shell
    [root@hub masterfiles] # echo HI >> file
    [root@hub masterfiles] # git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    #
    # Changed but not updated:
    #   (use "git add <file>..." to update what will be committed)
    #   (use "git checkout -- <file>..." to discard changes in working directory)
    #
    #	modified:   file
    #
    no changes added to commit (use "git add" and/or "git commit -a")

---
## Diff to validate detail of content change
    !shell
    [root@hub masterfiles] # git diff
    diff --git a/file b/file
    index 45b983b..313352b 100644
    --- a/file
    +++ b/file
    @@ -1 +1,2 @@
     hi
    +HI

---
## Stage and commit the changes
    !shell
    [root@hub masterfiles] # git add file
    [root@hub masterfiles] # git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commit.
    #
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	modified:   file
    #
    # git commit -m "Modified file"
    [master fd94885] Modified file
     1 files changed, 1 insertions(+), 0 deletions(-)
    # git status
    # On branch master
    # Your branch is ahead of 'origin/master' by 1 commits.
    #
    nothing to commit (working directory clean)

---
## Publish the change
    !shell
    [root@hub masterfiles] # git push
    Counting objects: 7, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (4/4), done.
    Writing objects: 100% (5/5), 493 bytes, done.
    Total 5 (delta 2), reused 0 (delta 0)
    Unpacking objects: 100% (5/5), done.
    To /opt/cfengine/masterfiles.git
       c886caf..fd94885  master -> master

---
## Remove a file
    !shell
    [root@hub masterfiles] # git rm file
    # rm 'file'
    [root@hub masterfiles] # git status
    # On branch master
    # Changes to be committed:
    #   (use "git reset HEAD <file>..." to unstage)
    #
    #	deleted:    file
    #
    # git commit -m "Remove file"
    [master 4c9d46d] Remove file
     1 files changed, 0 insertions(+), 3 deletions(-)
     delete mode 100644 file

---
## Publish the change
    !shell
    [root@hub masterfiles] # git push
    Counting objects: 3, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (2/2), done.
    Writing objects: 100% (2/2), 230 bytes, done.
    Total 2 (delta 1), reused 0 (delta 0)
    Unpacking objects: 100% (2/2), done.
    To /opt/cfengine/masterfiles.git
       92660a9..4c9d46d  master -> master

---
## Place masterfiles into the repository
    !shell
    [root@hub masterfiles] # rsync -avz /var/cfengine/masterfiles/ .
    [root@hub masterfiles] # git add -A
    [root@hub masterfiles] # git commit -m "Seed repository with masterfiles"
    [root@hub masterfiles] # git push

---
## Configure masterfiles for git integration

    !shell
    [root@hub masterfiles]# echo '{ "classes": { "cfengine_internal_masterfiles_update": [ "policy_server" ] } }' > def.json
    [root@hub masterfiles]# git add def.json
    [root@hub masterfiles]# git commit -m "Enable automatic masterfiles update from repository"
    [master c206654] Enable automatic masterfiles update from repository
     1 file changed, 1 insertion(+)
     create mode 100644 def.json
    [root@hub masterfiles]# git push
    warning: push.default is unset; its implicit value is changing in
    Git 2.0 from 'matching' to 'simple'. To squelch this message
    and maintain the current behavior after the default changes, use:

      git config --global push.default matching

    To squelch this message and adopt the new behavior now, use:

      git config --global push.default simple

    See 'git help config' and search for 'push.default' for further information.
    (the 'simple' mode was introduced in Git 1.7.11. Use the similar mode
    'current' instead of 'simple' if you sometimes use older versions of Git)

    Counting objects: 4, done.
    Delta compression using up to 2 threads.
    Compressing objects: 100% (3/3), done.
    Writing objects: 100% (3/3), 370 bytes | 0 bytes/s, done.
    Total 3 (delta 1), reused 0 (delta 0)
    To /opt/cfengine/masterfiles.git
       a181449..c206654  master -> master

---
## Activate current update policy with enablement class
    !shell
    [root@hub masterfiles]# cf-agent --no-lock \
    --verbose \
    --define cfengine_internal_masterfiles_update \
    --file update.cf

---
## Verify presence of def.json
As you recall, we put the def.json into the repository not in /var/cfengine/masterfiles directly. We want to make sure that masterfiles is updating from our repository.

    !shell
    [root@hub masterfiles]# cat /var/cfengine/masterfiles/def.json

---
## Review
Now when the agent runs on hosts that define `policy_server` policy will be
activated that keeps /var/cfengine/masterfiles up to date with whats in the
repository as configured in mission portal (which by default is
`/opt/cfengine/masterfiles.git`).

This means new policy will be distributed as you push it into the repository.
[Continuous delivery](https://en.wikipedia.org/wiki/Continuous_delivery) FTW!

---
## Git command reference
<table>
  <tr>
   <td>git status</td>         <td>git pull --rebase</td>
  </tr>
  <tr>
   <td>git diff</td>           <td>git grep</td>
  </tr>
  <tr>
   <td>git add</td>            <td>git log</td>
  </tr>
  <tr>
   <td>git diff --cached</td>  <td>git checkout -b new_feature</td>
  </tr>
  <tr>
   <td>git commit</td>         <td>git push origin</td>
  </tr>
</table>

---
## Pop Quiz

* How do you get an overview of the changes to your clone?
* How can you easily search a git repository?
* What **must** you do in order to make changes?
