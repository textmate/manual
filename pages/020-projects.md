# Projects

TextMate 1.x allowed you to add and group files in a source list, which served as input for “project actions” such as the :ref:`file chooser` and multi-file searching.

This functionality is not available in TextMate 2, instead you select a folder to use as a project, and TextMate will treat items in that folder as belonging to the project. Unwanted items can be excluded by :ref:`filtering files`, and symbolic links can be created to reference items outside the folder, though when referencing other folders, they are not followed by default by the :ref:`file chooser` and during :ref:`searching`, but this can be enabled.

<!-- TODO Should probably allow the file browser to expand symbolic links -->

The main reason for the change is that any organization done inside TextMate is not understood by third party tools. For example if you wish to use version control, you will find that pretty much all version control systems work on a folder, not on a set of items defined by a `.tmProject` file. Even many of TextMate’s own bundle commands are made to work with a “project folder”.

## Project Folder

The project folder is used by the :ref:`file chooser`, :ref:`searching`, is exposed to :ref:`commands` as the `TM_PROJECT_DIRECTORY` :ref:`variable <variables>`, and is also the folder from where :ref:`settings <file-settings>` are read when there is no document path.

When opening a folder, for example by dragging the folder to the TextMate application icon, the window created will have the dragged folder associated with it, as that window’s project folder. When opening a single file, it will use the parent folder of that file.

You can see the project folder’s name in the window title or you can use :menu:`Go → Project Folder (⇧⌘P)` to show the project folder in the :ref:`file browser`.

If you wish to change the project folder then you can use the file browser to navigate to the new desired project folder, open the drop-down menu at the top, and select :menu:`Use «folder» as Project Folder`.

It is possible to explicitly set the project folder via :ref:`file settings`. The key to use is `projectDirectory` and it would normally be set to `$CWD`, though we generally do not recommend this, as the implicit setting is more flexible, for example it makes it easy to open a subset of the project as a new project, where searching and the file chooser is limited to this subset.

You can use :menu:`Go → Enclosing Folder (⌘↑)` with the file chooser or search dialog open to temporarily use parent folders as source for these actions.

## Window Title

The window title contains the document name, the name of the project folder (if any) and the current branch, if the project is using a version control system that supports branches. This is done via :ref:`file settings` using the `windowTitle` key, here are the default settings:

	windowTitleSCM     = '${TM_SCM_BRANCH:+ ($TM_SCM_NAME: $TM_SCM_BRANCH)}'
	windowTitleProject = '${projectDirectory:+ — ${projectDirectory/^.*\///}}'
	windowTitle        = '$TM_DISPLAYNAME$windowTitleProject$windowTitleSCM'

If you wish to change the title you can make use of the two `windowTitleProject` and `windowTitleSCM` variables to optionally include project and version control info in your custom title.

For example, if we want to always show the parent folder of the current document we can add this to the project’s `.tm_properties` file:

	windowTitle = "${TM_FILEPATH/.*\/(.*\/).*/$1/}$TM_DISPLAYNAME$windowTitleProject$windowTitleSCM"

Or if we want to show the path as relative to the project root, we can use:

    windowTitle = '${TM_FILEPATH:?${TM_FILEPATH/${CWD}.//}:$TM_DISPLAYNAME}$windowTitleProject$windowTitleSCM'

## Tabs

### Creating Tabs

Most ways to open a file inside TextMate will make it open as a new tab in the current window. Files opened from outside TextMate will open as a new tab if the file is a descendent of an existing window’s project folder, or if a project has been explicitly requested for the file being opened. The latter is possible using :ref:`mate` and setting the `TM_PROJECT_UUID` :ref:`environment variable <variables>`, something that is implicitly done when `mate` is called by a :ref:`command` running inside TextMate, meaning bundle commands that open new files will  normally open these as tabs in the existing project.

Selecting :menu:`Window → Merge All Windows` will move all open documents in non-minimized windows to a single window (with tabs). That minimized windows are excluded from the merging can be exploited if the goal is to merge all but a few documents into a single window: minimize the windows that should be left alone, and then select the action.

Once a file has been opened in a new tab, it is possible to move it to a new window by selecting :menu:`Window → Move Tab to New Window`, by selecting the same action in the tab’s context menu, or by double-clicking the tab.

Tabs can also be dragged between windows but if dropped outside the tab bar of an existing TextMate window, the drag will act as if the file itself was dropped, rather than create a new window for the document. This is useful when you need the path of a document inserted into your terminal, as you can then drag and drop the desired tab to the terminal window.

#### Default File Type for New Tabs

When selecting :menu:`File → New Tab (⌥⌘N)`, the file type is read via :ref:`file settings` using the `fileType` key scoped to `attr.untitled`. If for example we wish new files in our :file:`/path/to/project` should default to markdown, then create :file:`/path/to/project/.tm_properties` containing:

	[ attr.untitled ]
	fileType = "text.html.markdown"

This setting is also used by :menu:`File → New File (⇧⌘N)`.

### Closing Tabs

A common problem is being left with too many open tabs. In an attempt to counter that, TextMate will automatically close tabs that hasn’t been used in a while, when the tab bar overflows.

Additionally there are a few explicit ways that you can close multiple tabs in a single action:

- Hold down option (⌥) when opening a file either via the :ref:`file browser` or :ref:`file chooser`. For the latter, you normally open files via return (↩) so here you would press option-return (⌥↩).
- Use :menu:`File → Close Other Tabs (⌃⌘W)` or :menu:`File → Close All Tabs (⌃⌥⌘W)`.
- Right-click a tab and select any of the close actions, e.g. :menu:`Close Tabs to the Right`.

Sometimes you have documents that should stay open, like a to-do list, which may prevent the use of a batch close action. In this case, right-click the tab in question and select :menu:`Sticky` (toggle). When a tab is made sticky, the batch close actions will leave it open.

## File Browser

Opening files from the file browser is done by single-clicking the file’s icon, double-clicking the file name, or using command-down (⌘↓) when focus is in the file browser.

Descending into file packages or application bundles can be done either by selecting :menu:`Show Package Contents` from the context menu, or by holding option (⌥) while double-clicking the item or single-clicking the item’s icon.

### Location and Selections

Many :ref:`commands` use the file browser selection as the set of files to work on, for example if you wish to see uncommitted changes for a subset of files, select those files before invoking the version control command. If there are no selection, the commands will generally work on the entire project.

For this reason, there are two very useful actions, namely :menu:`Go → Current Document (⌃⌘R)` which will reveal and select the current document in the file browser. In the file browser’s context menu there is :menu:`Select None (⇧⌘A)` which will deselect all selected items. The key equivalent for this item works even when focus is not in the file browser.

In the :menu:`Go` menu you can find a few other useful actions for changing location of the file browser. Be aware that the key equivalent of :menu:`Go → Back (⌘[)`, :menu:`Go → Forward (⌘])`, :menu:`Go → Enclosing Folder (⌘↑)`, and :menu:`Go → Other Folder… (⇧⌘G)` is only available when focus is in the file browser, and due to technical limitations, will not show in the menu.

### Drag and Drop

Drag and drop can be used to move files from one location to another but by holding down command (⌘) the drop will result in a duplicate, and control (⌃) will cause a symbolic link to be created at the drop location.

### Keyboard Usage

Moving keyboard focus to the file browser can be done by selecting :menu:`Navigate → Move Focus to File Browser (⌥⌘⇥)`. Use the same action to move focus back to the document.

When focus is in the file browser, the following key equivalents can be used.

| Key Equivalent | Action                                 |
| -------------- | -------------------------------------- |
| ⌘↓, ⌘O         | Open selected item(s)                  |
| Space          | Quick Look selected item(s)            |
| ↩              | Rename selected item                   |
| ⌘D             | Duplicate selected item(s)             |
| ⌘X, ⌘C         | Cut or copy selected item(s)           |
| ⌘V             | Paste item(s)                          |
| ⌘⌫             | Move selected item(s) to trash         |
| ⌘Z, ⇧⌘Z        | Undo or redo last action               |
| ⌥⌘I            | Show hidden files                      |
| ⌘[, ⌘←         | Go back in history                     |
| ⌘], ⌘→         | Go forward in history                  |
| ⌘↑             | Go to enclosing folder                 |
| ⇧⌘G            | Go to folder…                          |
| ⇧⌘F            | Search with source based on selection  |
| ⌥F2            | Show context menu                      |

When you cut one or more items, they will not be removed before you paste them somewhere else, as the action is meant for moving items. Use delete instead of cut, if you want the item to be removed.

### Effective Folder

Actions like :menu:`File → New File (⇧⌘N)` require a folder which is obtained from the file browser in this way:

If something is selected, the folder containing the selected item(s) will be used as the effective folder, unless a single expanded folder is selected, in this case, the selected folder is used. If nothing is selected, the top folder showing in the file browser is used.

### Custom Commands

It is possible to add your own :ref:`commands` to the file browser’s action menu.

This is done by creating a bundle command and setting its :ref:`semantic class` to `callback.file-browser.action-menu`.

An example of a command that appear in the file browser’s action menu is :menu:`Bundles → Shell Script → Open Terminal (⌃⇧O)`. The :menu:`Compress Selected Items` and :menu:`Show Images` are also bundle commands.

<!-- TODO Improve how commands are setup to be used in the file browser -->
<!-- TODO Document what file browser commands can expect in terms of variables and input/output -->
