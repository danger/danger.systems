---
title: Troubleshooting
subtitle: all broken
layout: guide
order: 7
---

### I want to work locally on my Dangerfile

OK, so, you can use `bundle exec danger local` to have Danger run the last merged PR in your commit history ( note: run `bundle exec  danger local --help` to see extra options.)

This will run the Danger environment locally, making it possible to iterate and verify syntax etc.

Make sure to setup the `DANGER_GITHUB_API_TOKEN` and optionally `DANGER_GITHUB_HOST` environment values before attempting to run `local`. If you are trying to access an Enterprise GitHub instance, `DANGER_GITHUB_HOST` must be set.

### I want to be a Danger Wizard

![](http://i.imgur.com/QCwKwKQ.gif)

Alright, alright. So the real key to working locally, is `bundle exec danger local --pry`.

Here's some tips for using pry inside Danger. You will start off running the REPL _inside_ the `Dangerfile`.

[Pry is special][pry] because it provides a UNIX folder-like structure for your object graph. You can use `ls` to see all the local variables, and attributes for your current `Dangerfile`. Then use `cd` to change the state to another object, and `cd ..` to go back.

Inside the `Dangerfile`, plugin instances are not in the default list alas, but you can get them all with `@plugins.keys.map(&:instance_name)`.

For example, to look around inside your `git` state, do a `cd git` and do `ls` again. If you want an in-depth overview of the current object use `inspect`.

To check all your warnings, errors, markdowns and messages - `cd` into the `messaging` plugin, then run `status_report` to see what has happened.

If you're interested in understand pry more, I strongly recommend digging into [their docs][pry].

### Circle CI doesnt run my build consistently

Yeah... We're struggling with that one. It's something we keep taking stabs at improving, so [keep an eye on the issues][circle_issues]. Ideally this issue will get resolved and we'll get it [fixed for free][circle_pr].


[circle_issues]: https://github.com/danger/danger/search?q=circle&state=open&type=Issues&utf8=✓
[circle_pr]: https://discuss.circleci.com/t/pull-requests-not-triggering-build/1213
[pry]: http://pryrepl.org
