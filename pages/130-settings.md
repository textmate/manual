# Settings

## File Settings

* `.tm_properties`
* Recording defaults (`Global.tmProperties`)
* Section selectors: scope selector or glob. Multiple values.
* Precedence.

The grammar used to parse the `.tm_properties` files are as below. Whitespace (in the form of spaces or tabs) is allowed between elements.

	file:          ( «line» )*
	line:          ( «comment» | ( «section» | «assignment» )? ( «comment» )? ) ( '\n' | EOF )
	section:       '[' «name» ( ";" «name» )* ']'
	name:          ( /[^\] \t\n]/ | /\\[\] \t\n\\]/ )+
	assignment:    «key» '=' «value»
	key:           ( /[^= \t\n]/ | /\\[= \t\n\\]/ )+
	value:         ( «single_string» | «double_string» | «bare_string» )
	single_string: "'" ( /[^']/ | /\\['\\]/ )* "'"
	double_string: '"' ( /[^"]/ | /\\["\\]/ )* '"'
	bare_string:   ( /[^ \t\n]/ | /\\[ \t\n\\]/ )+
	comment:       '#' ( /[^\n]/ )*

### Filtering Files

* File chooser
* File browser
* Folder search

## Scope Settings

* Pattern based highlight pairs (for movement)
* Indent based foldings
* Character classes (for completion, word movement, etc.)
* Indented soft wrap

## Hidden Settings

* line height, anti-alias, extended attributes, etc.

## Key Bindings

* Location of key binding files
* Keybinding syntax
* Indent aware movement actions
* Find and extend selection actions
