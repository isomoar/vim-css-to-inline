vim-css-to-inline
=================
Transforms plain css to JSX inline styles.

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

In normal mode plugin automatically transforms everyting between curly braces
`{}`. 

Customization
------
Use the `g:csstoinline_no_mapping` option and the `<Plug>` maps to customize the maps:

```vim
let g:csstoinline_no_mapping = 1
nmap tis <Plug>ToInlineN
xmap tis <Plug>ToInlineV
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



