# Text Editing

## Navigation

### Word Movement

Moving between words is done by holding option (⌥) and using arrow keys. Selecting can be done by additionally holding down shift (⇧), for example to select to the end of the word to the right of the caret, press ⌥⇧→.

Deleting to beginning or end of words can be done by holding down option when pressing the backward or forward delete keys. On laptop keyboards the forward delete key (⌦) is available by holding down the <kbd>fn</kbd> modifier key when pressing backward delete (⌫).

By default TextMate classifies a character as belonging to one of 3 groups: `word`, `space`, or `other`. Any sequence of characters belonging to the same group is considered a single unit for the purpose of word movement and other actions that break up the text, like word selection or :ref:`buffer completion`.

It is possible to change the group that text belongs to by adding a `characterClass` :ref:`scope setting`. For example the Source bundle sets `characterClass = 'escape';` using a scope selector of `constant.character.escape`. This means that in a code snippet like the following:

    str = "foo‸\nbar"

Using ⌥→ will move caret so we end up before `bar`:

    str = "foo\n‸bar"

This is because `\n` is matched by the :ref:`language grammar` and scoped as `constant.character.escape.*`, which the Source bundle tells TextMate has character class `escape`, so for the purpose of word movement, it is separate from `bar`, which has character class `word`.

### Sub-word Movement

If you are using variables with `camelCase` or `snake_case` then you can hold control (⌃) to move between sub-words, for example (using ⌃→):

    ‸someVariable        → some‸Variable
    ‸some_other_variable → some‸_other_variable

As with :ref:`word movement`, you can also use the control (⌃) modifier with shift (⇧) to make selections or delete to sub-word boundaries with control (⌃) and the forward and backward delete keys.

### Column Movement

Using arrow up/down when holding option (⌥) will move the caret to the first/last row in the current column. As usual, also hold down shift (⇧) to get it selected.

For example pressing ⌥⇧↓ in this example:

    1:  foo  = ‸quux
    2:  bar  =  corge
    3:  baz  =  grault
    4:  qux  =  garply

Will select from `quux` and down to just before `garply` like this:

    1:  foo  = [xxxxxxx
    2:  xxxxxxxxxxxxxxx
    3:  xxxxxxxxxxxxxxx
    4:  xxxxxxx]garply

This in itself may not seem like a useful feature, but once we have this (stream) selection, we can use :menu:`Edit → Select → Toggle Column Selection (⌥)` to turn it into a (zero-width) columnar selection. The option key (⌥) for this menu item means to press and quickly release the option key, don’t hold it down or press any other key.

The result becomes:

    1:  foo  = ‸quux
    2:  bar  = ‸corge
    3:  baz  = ‸grault
    4:  qux  = ‸garply

That is, we now have :ref:`multiple carets` and can make batch changes across all the lines.

### Paired Character Movement

Paired characters are things like braces, brackets, and parenthesis. These can be defined using the `highlightPairs` :ref:`scope setting`. The value is an array of arrays, each sub-array containing the first and last “character” in a pair. The character can be a string or a regular expression, for the latter, it should be surrounded by slashes.

For example the HTML bundle has this setting:

    highlightPairs = (
      ( '(', ')' ),
      ( '{', '}' ),
      ( '[', ']' ),
      ( '“', '”' ),
      ( '/<(?!area|base|basefont|br|col|frame|hr|img|input|isindex|link|meta|param)\w+[^>]*(?<!/)>/',
        '/</\w+>/'
      ),
    );

The last pair defined is done with regular expressions that match open and close tags.

The setting is both used to pairs when moving caret over one of the two items in a pair, but is also used to allow moving and selecting to pair boundaries.

Use control (⌃) with arrow up/down to move to the begin/end of the current pair. You can hold down shift (⇧) to make a selection. For example with the following code example:

    someFunction(foo, bar‸, baz.qux())

Press ⌃⇧↓ to select the last argument, resulting in:

    someFunction(foo, bar[xxxxxxxxxx])

It is also possible to use :menu:`Edit → Select → Enclosing Typing Pairs (⇧⌘B)` to extend the selection to include the immediate outer pairs defined, using that action would result in:

    someFunction[xxxxxxxxxxxxxxxxxxxx]

Since this is an :ref:`unanchored selection` we can use ⌥⇧← to further extend the selection so that it includes `someFunction`.

When the paired characters are on their own lines, as is often the case with braces, the selection will be extended to full lines, for example in this example:

    1:  int main (int argc, char const* argv[])
    2:  {
    3:     for(size_t i = 0; i < argc; ++i)
    4:     {
    5:        ‸printf("%zu: %s\n", i, argv[i]);
    6:     }
    7:     return 0;
    8:  }

Using :menu:`Edit → Select → Enclosing Typing Pairs (⇧⌘B)` will fully select line 4, 5, and 6.

Two convenient actions worth mentioning are :menu:`Bundles → Source → Wrap in Braces ({)` and :menu:`Bundles → Source → Unwrap Braces (})`. Both are only active when there is a selection, and they will wrap/unwrap and increase/decrease indent accordingly.

Slightly related is :menu:`Bundles → Source → Strip Wrap Characters (])`. This action is also active only when there is a selection, and will strip the outer “wrap characters” of the selection, those could be parenthesis, quotes, or similar.

### Bookmarks

You can use :menu:`Navigate → Toggle Bookmark (⌘F2)` to add a remove a bookmark for the current line. Getting back to this bookmark is either done by cycling through bookmarks, using :menu:`Navigate → Next Bookmark (F2)` and :menu:`Navigate → Previous Bookmark (⇧F2)`, or by finding the bookmark in the :menu:`Navigate → Go to Bookmark` submenu. This menu also allows you to clear all bookmarks for the current document.

You may find that using function keys require the use of the <kbd>fn</kbd> modifier key. This can be changed at the Keyboard page in System Preferences.

### Symbol Chooser

For languages that support it, the rightmost pop-up in the status bar shows the current “symbol” (often the function prototype or heading above the caret). This pop-up can be used to move the caret to another section of your document.

For keyboard navigation there is also :menu:`Navigation → Go to Symbol… (⇧⌘T)` which opens a panel which supports filtering similar to the :ref:`file chooser`.

The panel can be left open and will update as the document is edited. If you single-click an item in the list, the caret will move to the symbol clicked. Double-clicking will do the same but closes the panel.

The symbol list is constructed by including all the parts of the document for which the scope has a matching `showInSymbolList` :ref:`scope setting` set to `1` (true).

In addition to `showInSymbolList` there is a `symbolTransformation` setting which is one or more regular expression substitutions which are performed on the text extracted. The value of this setting should be: `s/«regexp»/«format»/«options»` optionally followed by `;` and more substitutions. It is also possible to put comments in the value, these start with `#` and end at the next newline.

So if we want to show Markdown headings in the list, which are lines that start with one or more `#` marks, then we first make sure our :ref:`language grammar` assigns a name to these, a simple rule could be the following:

    {  name = 'markup.heading.markdown';
       match = '^#{1,6}\s*(.*)$';
    },

Now we can target headings using a :ref:`scope selector` of `markup.heading.markdown`. We create a :ref:`scope setting` using this scope selector and make it:

    {  showInSymbolList = 1; }

This however will include the leading pound characters (`#`) in the list. We can either assign a name (via the :ref:`language grammar`) to the actual title, or we can perform a substitution to get rid of the pound characters. The latter has the advantage that we can change these to indent. This is done by changing the :ref:`scope setting` to:

    {  showInSymbolList = 1;
       symbolTransformation = 's/^#(#*)\s*(.*)/${1/#/\x{2003}/g}$2/';
    }

The transformation is a nested transformation. The outer match will capture all but the first pound character into capture register one and then the actual heading into capture register two. In the :ref:`format string` we change pound characters in capture register one into em-spaces (`\x{2003}`) and append the heading as-is.

### Freehanded Movement

It can sometimes be useful to move caret without being restricted by the line endings, for example if we wish to add aligned values to the following source:

    buttonMap = {
       kHome:
       kBack:
       kForward:
       kReload:
    }

Then we would have to add four spaces of padding after `kHome:` before typing `1`, then arrow down, which would require adding another four spaces of padding, etc.

Alternatively we can hold down option (⌥) while clicking (with the mouse) where we wish to type the first text. This gives us a caret that can be moved freely. That way, we can type `1` followed by arrow down and left, and then type `2`, etc. until we get:

    buttonMap = {
       kHome:    1
       kBack:    2
       kForward: 3
       kReload:  4
    }

Another way to activate this mode is by placing the caret at the end of a line and then use :menu:`Text → Move Selection → Right (⌃⌘→)`.

To leave the mode, either use the mouse and click somewhere in the text (without holding down option) or use :menu:`Text → Move Selection → Left (⌃⌘←)` (without a selection).

## Selection

* Select → Word, Scope, Enclosing Typing Pairs
* Wrapping selection: paired characters, HTML tags
* Indenting selection: increase, decrease, estimate
* Moving selected text

### Unanchored Selection

* For extending

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

See also: Completion Commands, character classes

## Macros

* Record, replay, and save

## Auto-indenting Text

* How to configure
* How to disable
* Smart tab behavior

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
