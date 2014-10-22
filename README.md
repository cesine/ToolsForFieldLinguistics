[![Build Status](https://travis-ci.org/cesine/ToolsForFieldLinguistics.svg)](https://travis-ci.org/cesine/ToolsForFieldLinguistics)


# ToolsForFieldLinguistics

A collection of scripts and recipes for fieldlinguistics and RAs in data heavy labs

## Getting Started
### On the server
Install the module with: `npm install tools-for-field-linguistics`

```javascript
var ToolsForFieldLinguistics = require('ToolsForFieldLinguistics');
ToolsForFieldLinguistics.init(); // "init"
```

### In the browser
Download the [production version][min] or the [development version][max] or use bower `bower install tools-for-field-linguistics`.

[min]: https://raw.github.com/cesine/ToolsForFieldLinguistics/master/dist/tools-for-field-linguistics.min.js
[max]: https://raw.github.com/cesine/ToolsForFieldLinguistics/master/dist/tools-for-field-linguistics.js

In your web page:

```html
<script src="dist/tools-for-field-linguistics.min.js"></script>
<script>
init(); // "init"
</script>
```

In your code, you can attach ToolsForFieldLinguistics's methods to any object.

```html
<script>
var exports = Bocoup.utils;
</script>
<script src="dist/tools-for-field-linguistics.min.js"></script>
<script>
Bocoup.utils.init(); // "init"
</script>
```

## Documentation
https://github.com/cesine/ToolsForFieldLinguistics/tree/master/docs

## Examples
For screencasts to see how you can use the code:
https://github.com/cesine/ToolsForFieldLinguistics/tree/master/watchmes

For sample code to see how you can use and re-use the code, see the specs and tests:
https://github.com/cesine/ToolsForFieldLinguistics/tree/master/test


## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. If you know how, add unit tests for any new or changed functionality. The project comes with automated linting and testing for your javascript code using [Grunt](http://gruntjs.com/).


###Contributing Examples

Want to contribute? (easy) 

1. Click on Edit on any of the pages on GitHub
3. Edit the code, and commit your changes saying what you changed (git commit -m "added some more regex to the text cleaner"). GitHub will create an Issue for you which asks us to bring in your changes

Want to contribute? (advanced)

1. Fork the repo
2. Create a branch which describes your change (git checkout -b more_regex)
3. Make your modifications
4. Run the dev tools (linter and tests if you modified the javascript)
 $ npm install
 $ grunt 
5. Commit your changes (git commit -m "added some more regex to the text
cleaner")
6. Push to the branch (git push origin more_regex)
7. Create a Pull Request (adding more details if necessary)


JavaScript Syntax highlighting using Sublime
-------------------------
* Download the source code
* Open the entire folder


Groovy Syntax highlighting using Eclipse
-------------------------
* Download the source code
* Create a Groovy project and import the source files


## License
Copyright (c) 2010-2013 cesine, hisakonog
Licensed under the Apache 2.0 license.
