# vim-term-completion

Adds a "Terminal" command (and friends) to vim8+ that uses bash completion

## Features

- Uses bash completion for the command line.
- Supports vertical, tab and regular modes for opening a new `:terminal` window.

## Examples

- Use `bash` command completion while building the `git log --oneline` command to run in a `:terminal`:

  ```
  :Terminal gi<TAB> lo<TAB> --one<TAB><ENTER>
  :Terminal git log --oneline
  ```

- Open a Terminal using vertical mode:

  `:vertical Terminal ls`
   **or**
  `:VTerminal ls`
  **or just**
  `:VT ls`

- Open a Terminal using "new tab" mode:

  `:tab Terminal ls`
  **or**
  `:TTerminal ls`
  **or simply**
  `:TT ls`

## Installation

- Vundle:
  `Plugin 'wwade/vim-term-completion'`

- Plug:
  `Plug 'wwade/vim-term-completion'`

- Pathogen
  `git clone https://github.com/wwade/vim-term-completion ~/.vim/bundle/vim-term/completion`
