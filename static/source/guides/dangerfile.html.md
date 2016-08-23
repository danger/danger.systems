---
title: The Dangerfile
subtitle: The Dangerfile
layout: guide
order: 2
---

A `Dangerfile` is a [Ruby DSL][dsl]. Before the ruby code inside your `Dangerfile` is executed, she grabs useful bits of data about: the CI environment, the git diff, and the code review details. There is a full writeup of what happens in ["What does Danger do?"][wot_do]. For now that's enough.

The `Dangerfile` is where you create your rules, there are no hard and things to recommend here I'm afraid.

Where to go from here:
- [Working locally on your `Dangerfile`][troubleshooting]

[wot_do]: /guides/what_does_danger_do.html
[dsl]: https://www.infoq.com/news/2007/06/dsl-or-not
[troubleshooting]: /guides/troubleshooting.html#i-want-to-work-locally-on-my-dangerfile
