# Scopes

* Introduction to scopes blog post

## Attribute Scope

* SCM scopes: `attr.scm.*`.
* Build system scopes (Makefile, Xcode, etc.): `attr.project.*`.
* `attr.rev-path`, `attr.os-version`.
* `attr.untitled`, `attr.file.unknown-encoding`, `attr.unknown-filetype`.

## Dynamic Scope

* Left scope: `dyn.caret.begin.(line|document)`, right scope: `dyn.caret.end.(line|document)`.
* Misspelled words: `dyn.misspelled`.
* Mouse-clicks: `dyn.modifier.(shift|control|option|command)`.
* The scope contains `dyn.selection` and/or `dyn.caret.*` based on the following rules:

	- If there is one or more selections: `dyn.selection`.
	- If there is a single zero-width selection: `dyn.caret.mixed.columnar`.
	- If there are multiple carets and/or selections: `dyn.caret.mixed`.
