# Version Control

TextMate will detect when a project is using Git, Mercurial, Subversion, or Perforce. When detected, it will add `attr.scm.«system»` as an :ref:`attribute scope`. This is to allow the proper bundle to be active, for example the actions in the Git bundle has a scope selector of `attr.scm.git` so that they only show under :menu:`Bundles → SCM (⌘Y)` when TextMate has detected, that git is used as version control system.

For Git, Mercurial, and Subversion, TextMate will call out to the appropriate shell command which, for each of the respective version control systems, can be set as the following :ref:`variables`: `TM_GIT`, `TM_HG`, and `TM_SVN`. If no variable is set, TextMate will try to find the shell command via the :ref:`search path`.

TextMate asks the version control system for a few values, which are exposed both as :ref:`dynamic variables` of the form `TM_SCM_«variable»` and as `attr.scm.«variable».«value»` :ref:`attribute scopes <attribute scope>`. For example if the version control system reports that the current branch is `master` then the `TM_SCM_BRANCH` variable will be set to `master` and `attr.scm.branch.master` will be part of the current scope. The variable is mostly useful for decorating the :ref:`window title`.

TextMate also asks the version control system for file status. File status is used to add badges to file icons and to show deleted items as ghost items in the file browser, which allow selecting such items before using :menu:`Bundles → SCM → Commit (⌘Y)` or :menu:`Bundles → SCM → Revert… (⌘Y)`. You can see a list of modified and untracked files in your project by selecting :menu:`Go → SCM Status (⇧⌘Y)`.

TextMate also has bundles for the various version control systems which provide actions to see uncommitted changes, commit changes, and much more. It is outside the scope of this manual to document how each of these bundles work. Though on a general note, the actions will normally work with selected items in the file browser, falling back to entire project if there is no selection, which makes :menu:`Go → SCM Status (⇧⌘Y)` a very useful feature along with the :menu:`Select None (⇧⌘A)` file browser action.

It is worth mentioning that the line numbers in the diff renderings produced by actions in the Git bundle can be clicked, and will take you to the clicked line.

If for some reason you wish to disable the badges, TextMate’s built-in version control support can be disabled by setting the `scmStatus` key to `false` in :file:`~/.tm_properties`.
