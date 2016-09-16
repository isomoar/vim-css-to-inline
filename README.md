vim-css-to-inline
=================

Transforms plain css to JSX inline styles and vise versa

[![Build Status](https://travis-ci.org/isomoar/vim-css-to-inline.svg?branch=master)](https://travis-ci.org/isomoar/vim-css-to-inline)

![](http://i.imgur.com/dRLL2Ch.gif)

Installation
------------
With plugin manager like [Vim-plug](https://github.com/junegunn/vim-plug):

```vim
Plug 'isomoar/vim-css-to-inline'
```

Usage
--------
Default mappings:

* `tis` - transform to inline styles
* `fis` - transform from inline styles to css

In normal mode plugin automatically transforms everything between curly braces
`{}`. 

Customization
------
Use the `g:csstoinline_no_mapping` option and the `<Plug>` maps to customize the maps:

```vim
let g:csstoinline_no_mapping = 1
nmap <leader>is <Plug>ToInlineN
xmap <leader>is <Plug>ToInlineV
nmap <leader>cs <Plug>FromInlineN
xmap <leader>cs <Plug>FromInlineV
```
### Options

By default plugin transforms pixels to numbers:
```
12px -> 12
``` 
If you want to wrap pixel values in quotes, add this option to your *.vimrc*:
```vim
let g:csstoinline_wrap_pixels = 1
```



