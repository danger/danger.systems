---
title: Creating your first Plugin
subtitle: Plugin creation
layout: guide
order: 4
---

WIP - for now see the [danger-plugin-template repo](https://github.com/danger/danger-plugin-template).

---

So, you want to make a Danger Plugin? This is _awesome_. We all have common issues, and this is a great way to share code with the world. We've found once a single rule becomes longer than 10-15 lines of code, converting it into a plugin 

The concept of a Plugin in Danger is very simple. It's a subclass of `Danger::Plugin`. 

If you don't know about Ruby modules, then don't worry, think of it as Ruby namespacing. That's the `Danger::` bit. You'll have to create a class that is a subclass of `Plugin` inside a `Danger` `module`.

### Tech Specs

This subclass will be created automatically with a reference to the current `Danger::Dangerfile` ruby object. It will be created before the `Dangerfile`([s][multiple_danger]) are parsed by it. 

There are no ways to automatically execute code with knowledge of the current status. A plugin should get told to do some work from the user's `Dangerfile`(s).  

Your plugin is added as an attribute to the user's `Dangerfile`(s), this is based on your class name, but is editable. 

```ruby
def self.instance_name
  to_s.gsub("Danger", "").danger_underscore.split("/").last
end

# e.g. removes "Danger", converts camel case to snake case, and splits if there's any /s

# DangerProse -> prose
# DangerMyThing -> my_thing
# MyPlugin -> my_plugin 
``` 

#### Same Source

One of the great things about a Danger Plugin, is that the code is exactly the same as it was in your `Dangerfile`. A plugin has access to all of the same methods and attributes as you had when it was being parsed inside a `Dangerfile`. This is because anything your plugin doesn't understand get's first pass to see if it's reference to the current `Dangerfile` understands.

This is useful mainly in two things: 

* Low barrier to entry.
* You have access to all of the other plugins.

### Creating the Plugin

Starting is pretty simple, we have a [template][template]. As well as a command to get you started. Your first step is the name, the [Rubygems rule][gem_rules] is `[core_app]-[plugin]_[names]`. So, the first space is always a `-` then later spaces would be `_`. E.g. `danger-wizard_hat`.

Now you know the rules, in your development folder run `danger plugins create [name]`. This will create  

- same source
- always danger-thing
- `danger plugins create`
- overview of structure
- move the code in

#### Verifying the Plugin

- running the specs
- Show some examples of testing with Rspec

#### Adding the Gem to your Project

- Gemfile only

### Pushing to Rubygems

- registering
- pushing

### Getting it on Danger.Systems 

[multiple_danger]: /guides/faq.html#i-want-to-run-danger-across-multiple-repos
[template]: https://github.com/danger/danger-plugin-template
[gem_rules]: http://guides.rubygems.org/name-your-gem/