{ pkgs, ... }:

{
    programs.k9s = {
        enable = true;
        settings = {
            k9s = {
                liveViewAutoRefresh = "false";
                refreshRate = "2";
                maxConnRetry = "5";
                readOnly = "false";
                ui = {
                    enableMouse = "false";
                    headless = "false";
                    logoless = "false";
                    crumbsless = "false";
                    noIcons = "false";
                    # Toggles reactive UI. This option provide for watching on disk artifacts changes and update the UI live  Defaults to false.
                    reactive = "false";
                    # Uses in_the_navy skin located in your $XDG_CONFIG_HOME/skins/in_the_navy.yaml
                    skin = "kanagawa"; # => All clusters will use this skin unless otherwise specified in the context configuration file
                };
            };
        };
        skins = {
            kanagawa = {
                foreground = "&foreground \"#dcd7ba\"";
                background = "&background \"#1f1f28\"";
                black = "&black \"#090618\"";
                blue = "&blue \"#7e9cd8\"";
                green = "&green \"#76946a\"";
                grey = "&grey \"#727169\"";
                orange = "&orange \"#ffa066\"";
                purple = "&purple \"#957fb8\"";
                red = "&red \"#c34043\"";
                yellow = "&yellow \"#c0a36e\"";
                yellow_bright = "&yellow_bright \"#e6c384\"";

                k9s = {
                  body = {
                    fgColor = "*foreground";
                    bgColor = "*background";
                    logoColor = "*green";
                  };
                  prompt = {
                    fgColor = "*foreground";
                    bgColor = "*background";
                    suggestColor = "*orange";
                  };
                  info = {
                    fgColor = "*grey";
                    sectionColor = "*green";
                  };
                  help = {
                    fgColor = "*foreground";
                    bgColor = "*background";
                    keyColor = "*yellow";
                    numKeyColor = "*blue";
                    sectionColor = "*purple";
                  };
                  dialog = {
                    fgColor = "*black";
                    bgColor = "*background";
                    buttonFgColor = "*foreground";
                    buttonBgColor = "*green";
                    buttonFocusFgColor = "*black";
                    buttonFocusBgColor = "*blue";
                    labelFgColor = "*orange";
                    fieldFgColor = "*blue";
                  };
                  frame = {
                    border = {
                      fgColor = "*green";
                      focusColor = "*green";
                    };
                    menu = {
                      fgColor = "*grey";
                      keyColor = "*yellow";
                      numKeyColor = "*yellow";
                    };
                    crumbs = {
                      fgColor = "*black";
                      bgColor = "*green";
                      activeColor = "*yellow";
                    };
                    status = {
                      newColor = "*blue";
                      modifyColor = "*green";
                      addColor = "*grey";
                      pendingColor = "*orange";
                      errorColor = "*red";
                      highlightColor = "*yellow";
                      killColor = "*purple";
                      completedColor = "*grey";
                    };
                    title = {
                      fgColor = "*blue";
                      bgColor = "*background";
                      highlightColor = "*purple";
                      counterColor = "*foreground";
                      filterColor = "*blue";
                    };
                  };
                  views = {
                    charts = {
                      bgColor = "*background";
                      defaultDialColors = [
                        "*green"
                        "*red"
                        ];
                      defaultChartColors = [
                        "*green"
                        "*red"
                        ];
                    };
                    table = {
                      fgColor = "*yellow";
                      bgColor = "*background";
                      cursorFgColor = "*black";
                      cursorBgColor = "*blue";
                      markColor = "*yellow_bright";
                      header = {
                        fgColor = "*grey";
                        bgColor = "*background";
                        sorterColor = "*orange";
                      };
                    };
                    xray = {
                      fgColor = "*blue";
                      bgColor = "*background";
                      cursorColor = "*foreground";
                      graphicColor = "*yellow_bright";
                      showIcons = "false";
                    };
                    yaml = {
                      keyColor = "*red";
                      colonColor = "*grey";
                      valueColor = "*grey";
                    };
                    logs = {
                      fgColor = "*grey";
                      bgColor = "*background";
                      indicator = {
                        fgColor = "*blue";
                        bgColor = "*background";
                        toggleOnColor = "*red";
                        toggleOffColor = "*grey";
                      };
                    };
                    help = {
                      fgColor = "*grey";
                      bgColor = "*background";
                      indicator = {
                        fgColor = "*blue";
                      };
                    };
                  };
                };
            };
        };
  };
}
