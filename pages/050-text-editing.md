# Text Editing

## Navigation

* Word movement (⌥ + left/right)
* Sub-word movement (⌃ + left/right)
* Column movement (⌥ + up/down)
* Paired character movement (⌃ + up/down)
* Bookmarks
* Symbol chooser (⇧⌘T)
* Copy to find clipboard and find next/previous
* See Also: Search Options
* Search history (⌃⌥⌘F)
* Freehanded Movement: Activating via mouse (⌥-click)
* Incremental search (⌃S)
* Symbol Chooser

## Selection

* Select → Word, Scope, Enclosing Typing Pairs
* Wrapping selection: paired characters, HTML tags, indent and surround in block (<kbd>{</kbd>)
* Unwrapping selection: paired characters (<kbd>]</kbd>), decrease indent and strip block (<kbd>}</kbd>)
* Indenting selection: increase, decrease, estimate
* Moving selected text
* Anchored vs unanchored selections (for extending)

## Multiple Carets

* How to activate via: mouse, column selection + movement, column selection + unit selection, search actions, find next and extend selection
* Behavior with multiple carets: find next, copy/paste, etc.
* How to get back to a single caret

## Cut, Copy, and Paste

* Paste previous, next, and show clipboard history
* Paste with/without re-indent
* Configuring how to re-indent
* Duplicating text (⌃⇧D)
* Kill and yank

## Buffer Completion

The current word adfix is taken into consideration when hitting escape.

For example in this case:

	enum mark_t { kErrorMarkType, kWarningMarkType };
	mark_t m = ‸MarkType;

The resulting line will become:

	mark_t m = kWarning‸MarkType;

See also: Completion Commands

## Macros

* Record, replay, and save

## Auto-indenting Text

* How to configure
* How to disable

## Transposing Text

* ⌃T: Swap characters / lines
* ⌃T: Reverse characters in line / lines in selection
* ⌃T: Cycle (swap) selected words

## Spell Checking

* Selecting spelling suggestions (⌥F2)
* Disabling spell checking for scopes
* Setting default language for folders/files
* Correcting misspelled words (⌥F2 or right-click)

## Shell Command Filters

* Filtering through shell command (⌘|)

## Dropping Items

* Meaning of dragging (to document) with modifiers
* See Also: Drag Commands
