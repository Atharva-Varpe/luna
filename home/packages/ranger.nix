{ pkgs, ... }:
{
  # Enable ranger and add extended preview/runtime dependencies
  programs.ranger.enable = true;

  home.packages = with pkgs; [
    # General usage
    file
    sudo
    # python3
    jq
    python3Packages.chardet
    python3Packages."python-bidi"

    # Image/graphics previews
    libcaca          # provides img2txt and cacaview
    w3m                 # provides w3mimgdisplay
    ueberzugpp
    mpv
    kitty
    rxvt-unicode-unwrapped-emoji
    enlightenment.terminology
    # "rxvt-unicode"
    imagemagick         # provides convert
    librsvg             # provides rsvg-convert

    # Video/audio thumbnails
    ffmpeg
    ffmpegthumbnailer

    # Syntax highlighting for code
    highlight
    bat
    python3Packages.pygments   # provides pygmentize

    # Archives (preview/listing)
    atool
    libarchive          # provides bsdtar
    unrar
    p7zip               # 7z / 7zz
    gnutar              # tar
    unzip
    zip                 # zipinfo also provided by unzip
    gnused              # sed

    # HTML/text viewers
    lynx
    elinks

    # PDF tools
    poppler_utils       # pdftotext, pdftoppm
    mupdf               # mutool

    # DjVu
    djvulibre           # djvutxt, ddjvu

    # Ebooks
    calibre

    # Torrents/media metadata
    transmission        # transmission-show
    mediainfo
    exiftool

    # Office text
    odt2txt

    # JSON helpers
    # python3 already included above

    # SQLite tools
    sqlite
    python3Packages."sqlite-utils"

    # Jupyter notebooks conversion
    python3Packages.nbconvert

    # Fonts & 3D previews
    fontforge           # provides fontimage
    openscad

    # Diagrams (draw.io)
    drawio
  ];
}
