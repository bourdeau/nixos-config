{pkgs, ...}: {
  home.packages = with pkgs; [
    git
    gitflow
  ];

  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Pierre-Henri";
        email = "phbasic@gmail.com";
      };

      init.defaultBranch = "main";
      pull.rebase = true;
      rebase.autoStash = true;
      push.default = "current";
      branch.sort = "-committerdate";
      diff.colorMoved = "default";
      log = {
        abbrevCommit = true;
        decorate = "short";
      };
      color.ui = true;

      alias = {
        co = "checkout";
        br = "branch";
        ci = "commit";
        st = "status -sb";
        last = "log -1 HEAD";
        lg = "log --oneline --graph --decorate --all";
      };
    };

    lfs.enable = true;
  };
}
