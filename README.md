# danger.systems
The website generator for danger.systems, which is staticly generated on gh-pages

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
1