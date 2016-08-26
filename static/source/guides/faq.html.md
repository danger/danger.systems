---
title: Frequently Asked Questions
subtitle: FAQ
layout: guide
order: 6
---

#### Can I run Danger on my computer to test?

Yep! Use `danger local`. If you want to get into a debug REPL, use `danger local --pry`. You can find more on the [troubleshooting guide]()

#### I want to ignore a fail, just this once

You can tell Danger to ignore a specific warning or error by commenting on the body of your code review body:

```
> Danger: Ignore "Developer Specific file shouldn't be changed"
```

Then Danger would not show that message, and would not fail the build if it were the only `fail`.


#### I want to run Danger across multiple repos

To have consistent rules across the repos in your organisation, you can use a shared `danger.import_dangerfile "[repo]"`:

1. create a repo on your GitHub organization called `danger` (or `Danger`)
1. Add a `Dangerfile` to the root of that repo
1. The new `Dangerfile` is ran after the current repo's `Dangerfile`

Then, assuming Danger can reach the other repo, she will download the Dangerfile from that
repo and parse it in-place. This gives access to the same local and other environment variables.

#### Multiple Dangers

You can have each instance of Danger running on a different CI provider and even doing different validations. An use case would be:

* `basic` runs on a Linux environment (such as Circle CI) and validates the PR itself (title, etc)
* `compilation` runs on a Mac after running unit tests for your iOS app and comments about warnings, test failures, etc
* `uitests` runs on a Mac after running UI Unit tests and comments about test failures

``` sh
bundle exec danger --danger_id=unit_tests
```

#### I use a Build Matrix on Travis, can I run Danger once?

Yep, here is an example of moving to support that from [the Ruby Grape project](https://github.com/ruby-grape/grape/pull/1458).

#### Danger keeps getting refered to as "her/she", what gives?

When we were in the naming process of Danger, we went through a lot of names. In the end, it got named after Gem "Danger" McShane, who was involved in both the copy and the concept. While not a programmer herself, she's helped out with trying to understand the personality behind the project. Danger, the project, is a female, northern UK, command-line app into 80's punk/indie. Inspired by community efforts [like the Haçienda / Factory Records][hacienda].

<iframe src="https://embed.spotify.com/?uri=spotify%3Auser%3Aortatherox%3Aplaylist%3A39vTSdxtIKzpEybyvTs3Ll" width="300" height="380" frameborder="0" allowtransparency="true"></iframe>

Understandably, applying a gender to a genderless concept comes with it's own complications. To make it worse, female genders tend to be applied towards "[digital assistants][assistants]" which should raise questions on outdated-but-still-persisting gender stereotypes and patriarchical power structures. There is no answer that can completely absolve the disconnect I'm afraid.

[hacienda]: http://www.prideofmanchester.com/music/hacienda.htm
[assistants]: http://www.theatlantic.com/technology/archive/2016/03/why-do-so-many-digital-assistants-have-feminine-names/475884/

#### Danger is not posting to GitHub PRs, but everything looks fine?

Try logging in to your account that is writing the messages, it's possible that your account has triggered the bot detection algorithm on GitHub. This means that messages are sent correctly, but do not show up for anyone except the sender. This makes it more or less impossible to detect.