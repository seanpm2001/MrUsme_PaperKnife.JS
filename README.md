paperknife.js
-------------

paperknife.js is a RFC 2822 compliant e-mail address parser/validator developed with PEG.js as a pure JavaScript library that can be used on the in browsers as well as on the Node.js server-side.

## Installation

### Browser

```html
<script src="paperknife.min.js" type="text/javascript" charset="utf-8" async></script>
```

### Node.js

```bash
npm install --save @twostairs/paperknife
```

## Usage

```javascript
const Paperknife = require('paperknife/paperknife');
var splittedData = Paperknife.parse('Marius <marius@twostairs.com>');
console.log(JSON.stringify(splittedData));
```

Output:

```json
"[[{"type":"displayname","value":"Marius"},{"type":"localpart","value":"marius"},{"type":"domain","value":"twostairs.com"},{}]]"
```
