---
title: "Upgrading Hugo Site"
date: 2025-05-27T20:52:42+05:30
tags: ["tools", "hugo", "static-site"]
categories: ["blog"]
---

A normal day. You decide to resume blogging after ages. You look at your long ignored static generated site and try to build it. You hit enter and are met with the all too familiar "Error" message. But why? It was working the last time you ran this. It wasn't that long ago, was it? You look the timestamp of your last post and - damn! Four years ago. Alas! It really was that long ago.

And that dear reader is how I went down the rabbit hole of upgrading dependencies for building my site. The site which has seen far less effort in it's content than it has in its build process.

## Issues

The main issues I faced were:
- The binary version for [hugo](https://github.com/gohugoio/hugo) used to build the site originally was ancient, and netlify didn't support it.
- The [theme I was using](https://github.com/panr/hugo-theme-hello-friend) had been archived by the maintainer and thus hadn't been updated in a long time.
- Since the theme was now defunct, all the custom layout/template files I had written to override it were of no use anymore.
- The `tweet` shortcode had been deprecated and it broke all content pages using it.

## Initial Attempts

As always, I turned to google hoping that others had trodden upon a path I could walk. Fortunately I found some helpful posts:

- https://jvns.ca/blog/2024/10/07/some-notes-on-upgrading-hugo/
- https://justinjbird.com/blog/2023/shortcodes-to-the-rescue-twitter-embedded-tweet-failure/

These were helpful in seeing what all has changed in the past releases along with how to fix some of those issues.

After trying to fix the current site in-place and pulling several of my hair apart, I gave up and decided to rebuild the site and then copy the content over.

I should note that the combination of old hugo version and the previously used theme not being maintained, led to several chicken and egg problems that made fixing it difficult.

## Fixes

#### Theme Hunting

Since https://github.com/panr/hugo-theme-hello-friend was archived, I went looking for a relatively similar theme that also supports current hugo version.

So I went in the first obvious place - the forks of that very theme - https://github.com/panr/hugo-theme-hello-friend/forks.
This was a good call since the most active fork was https://github.com/rhazdon/hugo-theme-hello-friend-ng - a theme that perfectly met my criteria.

#### New Version, Old Look

I installed the latest release of hugo and initialized a new site in a separate directory - all this would be discarded after the migration is done. I initialized the git repository in order to track all the changes I made. Then I added the new theme. Once I got the site running, I copied over the posts which didn't have any breaking changes and rebuilt.

#### Twitter Tussle

Once I got the site resembling the older iteration, I turned to handle the `tweet` shortcode issue. Since the twitter widget no longer supports displaying the tweet with its iconic UI, I turned to screenshots. While I prefer links over screenshots, the latter does help in maintaining an archive of the content in case the original was unavailable.

I installed the browser extension [save-tweet](https://github.com/pjburnhill/save-tweet) which add a button under tweets to save them as screenshots.

Then I added a custom `tweet` shortcode which renders the tweet's screenshot (served from a static dir) along with its original URL.

I verified this setup by moving a post which used the shortcode. Since the build was green, I moved the rest.

#### Finishing Touches

Having the basic structure and all the posts in place, I started customizing the site to have the same layout as the old one. Once this was done, I deleted everything apart from `.git` from the original repo and copied over all the files. This allowed me to use git for viewing the changes made with respect to each file, from the perspective of the original site. It did reveal few minor things that I had missed.

As the last step I updated the netlify config to use the latest hugo version and deployed 🚀

Having done all that, I couldn't help but feel like I missed something...Ah right! The thing that started this endeavour - Writing the blog post itself!

Another time I guess 🤷
