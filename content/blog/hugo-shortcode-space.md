---
date: 2020-06-21
title: "Hugo Shortcodes: Adding Space"
tags: ["blog", "hack"]
---
I often found myself wanting to add empty spaces in my text. However the thought of having my text littered with a series of `&nbsp;` blocks was repulsive.

Given that most of the content I write is in markdown, and is rendered via Hugo in most cases - both personal & work, it made sense to develop a simple system which works with any hugo site.

Here's a simple shortcode that one can add to their static site, and inject `n` number of spaces, in a clean fashion.

{{< space 1 >}}

{{<gist rajat404 0687abbcb61bf969b98df1fea1432916 >}}

{{< space 1 >}}

Save this as `./layouts/partials/space.html` in your hugo repository.

Now you can add 10 spaces by adding `{{</* space 10 */>}}` in your markdown file.

### Example

```md
"As that I can see no way out but through"

{{</* space 50 */>}} -- Robert Frost
```

would be rendered as:

{{< highlight go >}}

"As that I can see no way out but through"

{{< space 50 >}} -- Robert Frost

{{< /highlight >}}

and would appear as:

"As that I can see no way out but through"

{{< space 50 >}} -- Robert Frost

### Bonus

Adding `{{</* space 1 */>}}` in a new line, will add an empty line. No more `<br>` tags!

```md
Text above

{{</* space 1 */>}}

Text below
```

and would appear as:

Text above

{{< space 1 >}}

Text below
