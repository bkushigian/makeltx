# Template Generation

## Introduction
To generate templates we define a simple grammar that will be stored in an XML.
This will make it possible to parse a template, put it into proper form XML
form, and be modified programmatically. LaTeX is not an easy language to parse
(it is Turing complete) so we will inevitably assume a simplified structure. For
example, the `\documentclass[...]{...}` is assumed to always come first,
followed by a package phase, followed by some macros, followed by page
formatting, etc. This may be generalized, but for now we keep it simple.
Further, we will assume that there is no content in the 'document' itself.

## Assumptions/Mentionables
* Every template starts with a `\documentclass` line, on its own line (modulo
  comments
* Every `\usepackage` statement exists on its own line
* Packages are declared before other statemtns
* Macros follow packages (this probably won't be necessary)

## Special Sequences
There are certain sequences that we will take special note of. For example,
`\documentclass` is both required and unique, and has important options that are
very important. Thus we will treat this individually, rather than as a generic
statement. Here are the sequences (or statements) that we will be treating
specially.:
* `\documentclass[opts]{params}`
* `\newcommand{\name}[optParamNum]{command}`
* `\renewcommand{\name}[optParamNum]{command}`
* `\title{title}`
* `\author{author}`
* `\date{date}`
* `\begin{document}` and `\end{document}`
* `\begin{environment}` and `\end{environment}` This is a more general version
  of the above, but it need not be unique.
* `\maketitle`



## Grammar

    Latex    ::= Preamble Header BeginDoc MakeTitle EndDoc
    Preamble ::= DocClass Packages Macros 
    Header   ::= Title Author Date 
    BeginDoc ::= begin '{' document '}'
