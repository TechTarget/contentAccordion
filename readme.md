# contentAccordion

## Summary

A plugin for creating an accordion style content viewer.

## Options

There are no options for this component at this time.

## The Markup

The markup for this component is in contentAccordion.jade. The title for each accordion item is held in an array within the contentAccordion.jade file. That array is also responsible for the number of sections within the accordion.

## Implementing

###Jade

When using Jade, make sure the index.jade file has the include that references your contentAccordion.jade file. 

```jade
include contentAccordion
```
###HTML

The content for the various sections is compiled from jade into the .html file. 

###CSS

Make sure to add the .css that is generated from the .scss file to the stylesheet that is associated with your website. 

###JavaScript

Make sure to add the minified version of contentAccordion.js to the javascript file that is already associated with your website. Also add the contentAccodion initializing function from the test.js file to your javascript file.

## CSS

This CSS for this component is generated from Sass. The icon located to the far right of the title bar is a background base64 image. It is set to toggle when the accordion title bar is clicked.

#### Note 

The content accordion does not support a persistent state function. If the page is refreshed then the default section (section 1) will be open. 

The content produced from this component is Lorem Ipsum. You will not be asked to input 'live' content.