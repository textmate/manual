# References

## Scope Selector

The scope selector syntax is as follows:

	atom:         «string» | '*'
	scope:        «atom» ('.' «atom»)*
	path:         '^'? «scope» ('>'? «scope»)* '$'?
	group:        '(' «selector» ')'
	filter:       ("L:"|"R:"|"B:") («group» | «path»)
	expression:   '-'? («filter» | «group» | «path»)
	composite:    «expression» ([|&-] «expression»)*
	selector:     «composite» (',' «composite»)*

* Left/right scope matching
* Begin/end anchoring, ignoring attribute scopes
* Wildcard matching
* Descendent selector

## Format String

	$«var»
	${«var»}
	${«var»:?«if»:«else»}
	${«var»:+«if»}
	${«var»:-«else»}
	${«var»:«else»}
	${«var»/«regexp»/«format»/«options»}
	${«var»:[/upcase][/downcase][/capitalize][/asciify]}
	
	(?«var»:«if»:«else»}
	(?«var»:«if»}
	
	\U, \L, \E, \u, \l
	\t, \r, \n, \x{HHHH}, \xHH

* Used for: grammar names, `.tm_properties` values, Preferences → Variables, replacement strings

For nested replacements, use named captures as variables are inherited.

## Glob String

	\«char»         -- Literal «char»
	?               -- Match one character
	*               -- Match zero or more characters¹
	**              -- Match zero or more path components
	{«a»,«b»,«c»}   -- Match «a» or «b» or «c»
	[«a»«b»«c»]     -- Match an «a», «b» or «c» character
	[«a»-«b»]       -- Match one character in the range «a»-«b»
	[^«a»-«b»]      -- Match one character not in the range «a»-«b»

Braces can be nested and contain other glob characters. Example:

	{*.{cc,mm,h},target,Makefile,.tm_properties}

Will match these files:

	source.cc
	source.mm
	source.h
	target
	Makefile
	.tm_properties

Ability to negate match by prefixing with `!`.

¹ The asterisk will not match slashes nor a leading period.

* Used in `.tm_properties`, find in folder

## Selection String

	selection    = «range» ('&' «range»)*
	range        = «pos» | «normal_range» | «column_range»
	pos          = «line» (':' «column»)? ('+' «offset»)?
	normal_range = «pos» '-' «pos»
	column_range = «pos» 'x' «pos»
	line         = [1-9][0-9]*
	column       = [1-9][0-9]*
	offset       = [1-9][0-9]*

This can be used with `mate -l`, _Go to Line…_, and the ⌘T dialog (by putting `:«selection string»` after the file name) — as for the latter, if a string on the find clipboard has this format, it will be the default value in ⌘T, this is useful if you have a line in Terminal like:

	main.cc:32: warning: no return statement.

You can then select `main.cc:32` press ⌘E and jump to Avian and press ⌘T followed by ↩ (one shortcoming is that ⌘T doesn’t show the currently open file, so it will only work if `main.cc` is not already the active file).

## Modified Property List

See TextMate 1.x manual.

## Regular Expression
