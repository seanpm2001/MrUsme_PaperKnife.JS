paperknife.js
=============

paperknife.js is a RFC 2822 compliant e-mail address parser/validator developed with PEG.js.

Usage
=====

```javascript
const Paperknife = require('paperknife/paperknife');
var splittedData = Paperknife.parse('Marius <marius@twostairs.com>');
console.log(JSON.stringify(splittedData));
```

Output:

```json
"[[{"type":"displayname","value":"Marius"},{"type":"localpart","value":"marius"},{"type":"domain","value":"twostairs.com"},{}]]"
```
