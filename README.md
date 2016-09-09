MakeLTX
=======

MakeLTX is a program written in Haskell for auto-generating LaTeX files from templates or by
specifying parameters. It is in a prototyping phase right now and has only
been tested on Ubuntu 16.04.

## Install

You need to have Stack installed for this. Clone this repo or download the zip. Then
``` bash
$ cd makeltx
$ stack install        # create the makeltx executable
$ makeltx install      # create ~/.makeltx
```
This will create an executable called `makeltx` in your stack path (you may need to add this to your `$PATH`
environment variable, it should be in something like `~/.local/bin`).

Finally, you will need to get some templates. Unfortunately, template download isn't automated but you can
[download from here](http://benkushigian.com/makeltx/templates/templates.tar.gz) and place them in your `~/.makeltx/templates` directory. Extract them (and get rid of the tarball if you'd like) and you're good to go!

## Running MakeLTX
`makeltx --help` gives a quick help message. There are three run modes: `install`, `run`, and `template`.

The easiest way to get started is to enter:
`makeltx template MathHomework` and it will create a brand new template for you! I'll be adding more templates soon.
To see a complete list of installed templates, enter `makeltx template --showall`.

Special Thanks
==============
Special thanks to Vel at [LatexTemplates.com](http://latextemplates.com) for letting me use his templates.

