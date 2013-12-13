paperknife.js
=============

paperknife.js is a RFC 2822 compliant e-mail address parser/validator developed with PEG.js.

Usage
=====

Include *paperknife.js* into your web project. *paperknife.peg.js* is the PEG.js (http://pegjs.majda.cz) source, out of which you can generate *paperknife.js* on your own.

```javascript
var splittedData = paperKnife.parse('Marius <marius@twostairs.com>');
JSON.stringify(splittedData);
```

Result:

```json
"[[{"type":"displayname","value":"Marius"},{"type":"localpart","value":"marius"},{"type":"domain","value":"twostairs.com"},{}]]"
```

That's basically it. :-)