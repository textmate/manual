# Searching

The primary search actions which you should learn the key equivalents for are:

* :menu:`Edit → Find → Find Next (⌘G)`
* :menu:`Edit → Find → Find Previous (⇧⌘G)`
* :menu:`Edit → Find → Show History (⌃⌥⌘F)`
* :menu:`Edit → Find → Use Selection for Find (⌘E)`

Another action is :menu:`Bundles → Text → Selecting → Extend Selection to Include Next (⌃W)`, more detail about this action can be found in the :ref:`search clipboard` section below.

TextMate’s search dialog can be brought up by selecting :menu:`Edit → Find → Find… (⌘F)`. Once this dialog is showing the :menu:`Edit → Find → Find All (⌥⌘F)` menu item will trigger the :button:`Find All` button in the search dialog and show you all results from the current document. When the search dialog is not showing, the same action will instead select all matches in the current document.

If you wish to search for tab or newline characters then you can press option-tab or option-newline to insert these in the search or replace fields. The fields will automatically grow with their content.

The sigma button (:button:`Σ`) in the search dialog can be used to count the number of results in the current document. Though the same information can be obtained via :button:`Find All` so this action is likely to be removed in a future version of TextMate.

## Folder Search

You can select :menu:`Edit ⇢ Find → Find in Project… (⇧⌘F)` to bring up the search dialog with the :label:`In` pop-up defaulting to the current project folder.  You can also click the magnifying glass in the file browser to open a search dialog pointing to the file browser’s :ref:`effective folder`, or switch focus to the file browser before pressing ⇧⌘F.

Should you wish to extend the search to a parent folder then you can use :menu:`Go → Enclosing Folder (⌘↑)` or interact with the :label:`In` pop-up menu.

When the :label:`In` pop-up is showing a folder you can select :button:`Find All` to perform a search across the files in the selected folder.

If you wish to limit the search then you can edit the :label:`matching` :ref:`glob string`. For example to only search HTML files you can make it `*.html` or if you wish to exclude all files in the :file:`vendor` folder, make it `!vendor/**`.

See :ref:`filtering files` for more options.

If you wish the search to follow symbolic links then you should enable this via the gear pop-up menu to the right of the :label:`matching` text field.

You can abort a running search by clicking the stop button that appear to the left of the status text, closing the window, or pressing ⌘..

<!-- TODO Allow navigating recent folders with ⌘[ and ⌘] -->

## Search Results

After a folder search you will see the results grouped by file. There are a few useful actions related to these results which we’ll go over in this section.

Using command ⌘1-⌘n will select the first result in the n’th file. It will also move focus to the results list, allowing you to use arrow up and down to move through the results.

Using :menu:`Edit → Find → Find Next (⌘G)` will select the first result, and subsequent uses will advance through the results. Likewise :menu:`Edit → Find → Find Previous (⇧⌘G)` will initially select the last result and move backwards through the results.

If you close the search dialog and use :menu:`Edit → Find → Find Next (⌘G)` in a document with no more results, TextMate will open the next file which have results and select the first result in this file.

From the gear menu in the find dialog you can select :menu:`Collapse Results (⌥⌘1)`. This is useful when you are only interested in which files contain matches and not the matches themselves.

Also in the gear menu are actions for copying the results to the clipboard. You can copy just the matching parts or the entire line with the match, either with or without file name. The first option, copying matching parts, is useful for :ref:`regular expression` searches, for example a project search for `href=".*?"` followed by :menu:`Copy Matching Parts` will provide you with a list of all links across all files. You can paste that into a new document and use :menu:`Bundles → Text → Sorting → Sort Documents & Remove Duplicates (F5)` to remove duplicates.

## Replacing

When you search for regular expressions the replacement string is interpreted as a :ref:`format string` where you can use captures from the search. Here is a [blog post about using captures and nested replacements in TextMate](http://blog.macromates.com/2012/nested-replacements/).

As mentioned in the blog post, TextMate offers you replacement previews. These are automatically shown when focus is in the :label:`Replace` text field.

For results that you do not wish to have replaced, uncheck the check box next to the result. By holding down option (⌥) when clicking a check box, all results for the corresponding file will be excluded or included.

## Search Clipboard

Similar to how you can copy text to the clipboard with :menu:`Edit → Copy (⌘C)` and paste it later with :menu:`Edit → Paste (⌘V)` you can use :menu:`Edit → Find → Use Selection for Find (⌘E)` to place the current selection on the (globally shared) search clipboard and use :menu:`Edit → Find → Find Next (⌘G)` or :menu:`Edit → Find → Find Previous (⇧⌘G)` to find the next or previous occurrence of the search string.

The content of the search clipboard is also used when opening the find dialog using :menu:`Edit → Find → Find… (⌘F)`.

TextMate maintains a history of your previous search strings and you can select :menu:`Edit → Find → Show History (⌃⌥⌘F)` to see previous search strings. If you close the list with return (↩) then TextMate will search for the next occurrence of the selected string, whereas closing the list with escape (⎋) will change the current string on the search clipboard but not perform a search.

In addition to placing selection on the search clipboard, you can also use :menu:`Edit → Find → Use Selection for Replace (⇧⌘E)`. This is useful if you want to perform a replacement and bypass the search dialog. The steps would be:

1. Select the string you wish to replace and press ⌘E.
2. Overtype the selection with the replacement, select it, and press ⇧⌘E.

After this you can use :menu:`Edit → Find → Replace All (⌃⌘G)`, make a selection and use :menu:`Edit → Find → Replace All in Selection (⌃⇧⌘G)`, or possibly :menu:`Edit → Find → Replace and Find (⌥⌘G)`

If you wish to replace only a few instances near the caret, it might be easier to select the first match and then use :menu:`Bundles → Text → Selecting → Extend Selection to Include Next (⌃W)`. This action will make the next occurrence of the currently selected string part of the selection, causing multiple occurrences to be selected. Use it to select all the occurrences you wish to replace, and then perform your replacement, as the changes you do to the first occurrence will be mirrored to all the other occurrences.

With no selection the action is :menu:`Edit → Select → Word (⌃W)` which means that for single word replacements you only need to place the caret on the word to be replaced and then press ⌃W until all the occurrences are selected.

## Search Options

Four options affect how the search works, these can be toggled either via the :menu:`Edit` menu or in the find dialog.

The options are as follows:

| Name               | Key Equivalent | Explanation
| ------------------ | -------------- | -----------
| Ignore Case        | ⌥⌘C            | Perform a case insensitive search.
| Regular Expression | ⌥⌘R            | Treat the search string as a :menu:`regular expression`.
| Ignore Whitespace  |                | Whitespace in the document and search string is ignored. This makes it easy to search for multi-line content regardless of its indentation.
| Wrap Around        | ⌥⌘A            | Start over from the top of the document when no match is found.

## Incremental Search

Selecting :menu:`Edit → Find → Incremental Search (⌃S)` will open a search field at the bottom of the window where a search string can be entered, and TextMate will show what it matches in the document. The search is case-insensitive and ignores whitespace.

While the search field is showing you can use the following key equivalents:

| Key Equivalent | Action
| -------------- | -----------
| ⌃S ⇥           | Find next
| ⌃⇧S ⇧⇥         | Find previous
| ↩ ⎋            | Close search field
