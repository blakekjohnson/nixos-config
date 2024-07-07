{ config, pkgs, ...}: {
  programs.xmobar = {
    enable = true;
    extraConfig = ''
      Config {
          font = "Fira Code"
        , borderWidth = 3
        , bgColor = "#272a3b"
        , fgColor = "#f8f8f2"
        , position = TopSize C 100 24
        , persistent = True
        , commands =
            [ Run Cpu ["-t", "cpu: (<total>%)", "-H", "50", "--high", "red"] 10
            , Run Memory ["-t", "mem: (<usedratio>%)"] 10
            , Run Date "date: %a %d %b %Y %H:%M:%S" "date" 10
            ]
        }
        , sepChar = "%"
        , alignSep = "}{"
        , template = "%cpu% | %memory% }{%date%"
    '';
  };
}

