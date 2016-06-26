# danger.systems
The website generator for danger.systems, which is staticly generated to gh-pages

# Key Components

To install:
``` sh
git clone https://github.com/danger/danger.systems
cd danger.systems
```

### danger.systems

The generator for the site.

It is a similar concept [to CocoaPods.org](https://github.com/cocoapods/cocoapods.org), in that there is generated data from Rake tasks.
This data is then used to generate the web page.

You can run a copy of the static site via:

``` sh
cd static
bundle
rake generate
rake serve
```

#### plugins.json

The master list of all plugins to show in Danger, right now it is just the name of your plugin on rubygems. 
We'll be checking for whether it pass when you run `danger plugin lint` in the dir, so please take the time to add all the extra metadata.  

### webhooks.danger.systems

This is a semi-perpetual web service, whose job is to listen out for webhook notificatiosn for new tags on any danger-plugin.
This will trigger a call to generate the new version of danger.systems, and deploy that on gh-pages. It does this by triggering
new builds on this repo from Travis CI.

You can run a copy of the static site via:

``` sh
cd webhooks
bundle
rake serve
```
