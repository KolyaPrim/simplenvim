# Git Integration: Fugitive and Gitsigns

This configuration integrates two powerful Git plugins: `vim-fugitive` for repository-level operations and `gitsigns.nvim` for line-level Git information.

## Fugitive (Repository-Level Operations)

Fugitive provides a Git wrapper within Neovim, allowing you to perform common Git commands without leaving your editor. All Fugitive keymaps are under the `<leader>g` prefix.

| Keymap        | Command              | Description                               |
| :------------ | :------------------- | :---------------------------------------- |
| `<leader>gs`  | `:Git`               | Open Git status window                    |
| `<leader>gc`  | `:Git commit`        | Open commit message buffer                |
| `<leader>gp`  | `:Git push`          | Push changes to remote                    |
| `<leader>gP`  | `:Git pull --rebase` | Pull changes with rebase                  |
| `<leader>gb`  | `:Git blame`         | Show Git blame for the current buffer     |
| `<leader>gD`  | `:Gdiffsplit`        | Open a diff view of the current file      |

### Typical Workflow Example

1.  **Check Status**: Press `<leader>gs` to open the Git status window.
2.  **Stage Changes**: In the status window, use `s` on a file to stage it, or `u` to unstage.
3.  **Commit**: Press `<leader>gc` to open a new buffer for your commit message. Write your message, then save and close (`:wq`).
4.  **Push**: Press `<leader>gp` to push your committed changes.

## Gitsigns (Line/Hunk-Level Information)

Gitsigns provides visual indicators (signs) in the sign column for added, changed, or deleted lines, and offers commands for interacting with Git hunks. All Gitsigns keymaps are under the `<leader>gh` prefix, with navigation using `[h` and `]h`.

| Keymap        | Command                  | Description                               |
| :------------ | :----------------------- | :---------------------------------------- |
| `[h`          | `gs.prev_hunk`           | Jump to the previous Git hunk             |
| `]h`          | `gs.next_hunk`           | Jump to the next Git hunk                 |
| `<leader>ghs` | `:Gitsigns stage_hunk`   | Stage the current hunk (visual mode also) |
| `<leader>ghr` | `:Gitsigns reset_hunk`   | Reset the current hunk                    |
| `<leader>ghS` | `:Gitsigns stage_buffer` | Stage all changes in the current buffer   |
| `<leader>ghu` | `gs.undo_stage_hunk`     | Undo staging of the current hunk          |
| `<leader>ghp` | `gs.preview_hunk`        | Preview the changes in the current hunk   |
| `<leader>gtd` | `gs.toggle_deleted`      | Toggle visibility of deleted lines        |
| `<leader>gbl` | `gs.blame_line`          | Show Git blame for the current line       |
