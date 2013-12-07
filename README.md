# AlgorithmsForResearchAssistants

Algorithms for research assistants in data heavy labs

## Getting Started
### On the server
Install the module with: `npm install AlgorithmsForResearchAssistants`

```javascript
var AlgorithmsForResearchAssistants = require('AlgorithmsForResearchAssistants');
AlgorithmsForResearchAssistants.init(); // "init"
```

### In the browser
Download the [production version][min] or the [development version][max].

[min]: https://raw.github.com/OpenSourceFieldlinguistics/AlgorithmsForResearchAssistants/master/dist/AlgorithmsForResearchAssistants.min.js
[max]: https://raw.github.com/OpenSourceFieldlinguistics/AlgorithmsForResearchAssistants/master/dist/AlgorithmsForResearchAssistants.js

In your web page:

```html
<script src="dist/AlgorithmsForResearchAssistants.min.js"></script>
<script>
init(); // "init"
</script>
```

In your code, you can attach AlgorithmsForResearchAssistants's methods to any object.

```html
<script>
var exports = Bocoup.utils;
</script>
<script src="dist/AlgorithmsForResearchAssistants.min.js"></script>
<script>
Bocoup.utils.init(); // "init"
</script>
```

## Documentation
_(Coming soon)_

## Examples
_(Coming soon)_

## Contributing
In lieu of a formal styleguide, take care to maintain the existing coding style. Add unit tests for any new or changed functionality. Lint and test your code using [Grunt](http://gruntjs.com/).

_Also, please don't edit files in the "dist" subdirectory as they are generated via Grunt. You'll find source code in the "lib" subdirectory!_

## Release History
_(Nothing yet)_

## License
Copyright (c) 2013 info@fielddb.org  
Licensed under the Apache 2.0 license.
