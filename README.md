# Git Police

Script for finding misbehaving git repositories.

Running `git-police` will search your home directory for repositories that are not up to date with their origin remote. It will also list repositories which have no origin remote, or are otherwise broken.

## Example Output

    $ git-police
    Repos without an origin:
        /home/miles/Documents/14th_Grade/6.042/pset4/.git
        /home/miles/Documents/14th_Grade/6.004/lab06/.git
        /home/miles/code/diphthongs/.git

    Repos out of sync with their origins:
        /home/miles/code/Amoeba/.git

    Repos with uncommitted changes:
        /home/miles/dotfiles/.git
        /home/miles/code/ceramics/.git
