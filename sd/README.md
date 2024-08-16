# Rose-Pine login theme for SDDM based on SDDM Sugar Dark

This is a customized version of the [Sugar Dark Theme](https://github.com/MarianArlt/sddm-sugar-dark) with colors from the [Rose Pine](https://rosepinetheme.com) palette.

All controls use the **[latest Qt Quick Controls 2](http://doc.qt.io/qt-5/qtquickcontrols2-index.html)** for [increased performance](https://blog.qt.io/blog/2015/03/31/qt-quick-controls-for-embedded/) on low end or even embedded systems and beautiful color transitions.

To learn how to customize the theme you should check the [Sugar Wiki on Github](https://github.com/MarianArlt/sddm-sugar-light/wiki/Before-you-begin) or the very well documented and included [`theme.conf`](theme.conf).
Here are some previews of nifty variable names you can set/unset/change to customize your sugar:
`ThemeColor`, `Font`, `HourFormat`, `ForceRightToLeft`, `TranslateUsernamePlaceholder`.

### Dependencies

[`sddm >= 0.18.0`](https://github.com/sddm/sddm), [`qt5 >= 5.11.0`](http://doc.qt.io/qt-5/index.html), [`qt5-quickcontrols2 >= 5.11.0`](http://doc.qt.io/qt-5/qtquickcontrols2-index.html), [`qt5-svg >= 5.11.0`](https://doc.qt.io/qt-5/qtsvg-index.html) [`qt5-graphicaleffects >= 5.11.0`](https://doc.qt.io/qt-5/qtgraphicaleffects-index.html)

*Make sure these are up to date!*

### Installing the theme

Clone this repository and move the contents to the theme directory of SDDM:

```
$ sudo mv sddm-rose-pine /usr/share/sddm/themes
```
This will move all files to a folder called "sddm-rose-pine" inside of the themes directory of SDDM.  

After that you will have to point SDDM to the new theme by editing its config file, preferrably at `/etc/sddm.conf.d/sddm.conf` *(create if necessary)*. You can take the default config file of SDDM as a reference: `/etc/sddm.conf/usr/lib/sddm/sddm.conf.d/sddm.conf`.  

In the `[Theme]` section simply add the themes name: `Current=sddm-rose-pine`. Also see the [Arch wiki on SDDM](https://wiki.archlinux.org/index.php/SDDM).

### NixOS

You can create a custom package and install it via environment.systemPackages.

```nix
# sddm-rose-pine.nix

{ stdenvNoCC
, fetchFromGitHub
, libsForQt5
}:

stdenvNoCC.mkDerivation rec {
  pname = "sddm-rose-pine-theme";
  version = "1.2";
  dontBuild = true;

  propagatedUserEnvPkgs = [
    libsForQt5.qt5.qtgraphicaleffects
  ];

  src = fetchFromGitHub {
    owner = "lwndhrst";
    repo = "sddm-rose-pine";
    rev = "v${version}";
    sha256 = "+WOdazvkzpOKcoayk36VLq/6lLOHDWkDykDsy8p87JE=";
  };

  installPhase = ''
    mkdir -p $out/share/sddm/themes
    cp -aR $src $out/share/sddm/themes/rose-pine
  '';
}
```

```nix
# configuration.nix

{
  services.xserver.displayManager.sddm.theme = "rose-pine";

  # ...

  environment.systemPackages = with pkgs; [
    # Install the derivation
    (callPackage ./sddm-rose-pine.nix {})
  ];
}
```

### Theming the theme

Sugar is extremely customizable by editing its included `theme.conf` file. You can change the colors and images used, the time and date formats, the appearance of the whole interface and even how it works.  
And as if that wouldn't still be enough you can translate every single button and label because SDDM is still lacking behind with localization and clearly [needs your help](https://github.com/sddm/sddm/wiki/Localization)!

Please read the [Sugar Wiki on Github](https://github.com/MarianArlt/sddm-sugar-light/wiki/Before-you-begin) for a detailed description of every variable available, what it does and the values it accepts. The `theme.conf` itself is also very well commented for you to get right at it.
