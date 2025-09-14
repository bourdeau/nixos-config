{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    gitflow
  ];

  programs.git = {
    enable = true;

    userName = "Pierre-Henri";
    userEmail = "phbasic@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      pull.rebase = true; # rebase instead of merge on pull
      rebase.autoStash = true; # stash changes automatically before rebase
      push.default = "current"; # push only current branch
      branch.sort = "-committerdate"; # list recent branches first
      diff.colorMoved = "default"; # highlight moved lines in diffs
      log.abbrevCommit = true;
      log.decorate = "short";
      color.ui = true;
    };

    aliases = {
      co = "checkout";
      br = "branch";
      ci = "commit";
      st = "status -sb";
      last = "log -1 HEAD";
      lg = "log --oneline --graph --decorate --all";
    };

    lfs.enable = true;
  };
}
