# Additional QA

This is a not-very-descriptive title, referring to QA done outside of FontBakery and my earlier QA work. This will encompass random issues I see crop up, plus specific Red Arrows / FontAudit checks.

## Drawbot Specimen

In making a specimen in Drawbot, I've noticed several interpolation errors.

![](assets/charset-tall3.png)

Errors I'm now seeing are messed-up interpolation from out-of-order contours in:
- `/perthousand`
- `/colon`
- `/divide` and `/divide.tnum`
- `/guillemotleft` and `/guillemotright`
- `/brokenbar`

![](assets/2018-12-10-20-40-27.png)

![](assets/2018-12-10-20-50-24.png)

Unfortunately, I have already adjusted the weight of the Regular master from an interpolated instance, so I can't simply fix contour order. I will have dig up the deleted file with the too-light "Regular" master, update it to the new `2000` UPM, make a new `440` weight instance, make that a master, and copy in the glyphs from there. As far as I can tell, it's only a few glyphs, so this won't take long. 

## Red Arrows Outlines QA


### Simplifying brackets?

There are some brackets that have Red Arrows for "Incorrect Smooth Curves" which have unnecessary points.

![](assets/bracket.gif)

These vertical extreme points cause no visible disruption, but also offer no benefit in hinting. I'll remove them in cases like this, where their removal does not visible alter the outlines.

### Simplifying curve anchors to prevent kinks

There are many control points on non-extreme parts of curves. This has the potential to cause kinking. However, in practice, the kinks that exist are invisible to the naked eye, even at a very large scale.

![](assets/curve-point.gif)


At SemiBold, this kink is invisible:
![](assets/2019-01-07-12-19-51.png)

At Medium, this kink is invisible:
![](assets/2019-01-07-12-21-40.png)

These invisible kinks are the case for many characters, like `/B`, `/D`, `/G`, and many more. With this font, the weight range between masters isn't very extreme, which is part of the reason these points don't cause much of a problem, whereas they likely would if something were really a thin-to-black interpolation range. Still, I'll check each for visible kinks.

### Removing inflections

I'll remove/correct inflections by copying outlines to a visible background layer to ensure the overall shapes change as little as possible.

![](assets/2019-01-07-12-27-47.png)

![](assets/2019-01-07-12-28-50.png)

In cases like the `/S`, I'll instead insert points with the GlyphsApp script [Insert Inflections](https://github.com/mekkablue/Glyphs-Scripts/blob/7ba28e691f6ce76650bf9da344cf230f7a5bb44a/Paths/Insert%20Inflections.py) from @mekkablue.

![](assets/s-inflections.gif)

...checking that it doesn't cause kinking in interpolated instances:

![](assets/2019-01-07-12-34-39.png)

![](assets/2019-01-07-12-37-02.png)

I'll actually add two points, then balance the handles. This keeps the original shape, but allows for more-balanced handles.

![](assets/2019-01-07-13-05-56.png)

And match that in the lowercase:

![](assets/2019-01-07-15-56-08.png)

Of course, in certain areas, removing inflections would likely cause more trouble than it would resolve, as in the `/Q` and `/asciitilde`

![](assets/2019-01-07-12-30-56.png)

Here I inserted a point into the long and prominent curve, plus balanced handles with Simon Cozens' [SuperTool](http://www.simon-cozens.org/supertool.html). This should improve output TTF curves. I left the other inflections, however, because they are too small or slight to correct without disrupting the curve. Checking in the exported VF, these curves don't seem to be too disruptive to TTF quadratic curves.

![](assets/2019-01-07-12-57-22.png)

![](assets/Q.gif)

![](assets/2019-01-07-12-31-36.png)


Some are pretty messy:

![](assets/2019-01-07-15-05-03.png)

This `/r` isn't related in shape to the `/n` or `/m`, so I'll change the connection to a sharp one, as I make a better curve:

![](assets/2019-01-07-15-11-43.png)

![](assets/2019-01-07-15-11-52.png)

![](assets/2019-01-07-15-10-50.png)

The inflections on the `/w` create visibly-poor curves. Let me fix that.

![](assets/2019-01-07-18-15-13.png)

Better:

![](assets/2019-01-07-18-19-42.png)

Some inflections, I'll leave, checking that they don't cause trouble in the TTF VF, such as these "s" shapes:

![](assets/s-shapes.gif)


### Fractional transformation

Probably due to my previous work of making a slightly-heavier "regular" master, the /Tbar has a slight fractional X translation. Because I don't see this much elsewhere, I'll manually correct this one rather than writing a script.

![](assets/2019-01-07-14-08-51.png)


### Unnecessary control points

There are quite a few control points that do little to nothing for the actual shapes, such as this very small flat segments in `/e`-shapes.

![](assets/2019-01-07-14-37-35.png)

It's easy to remove these points and achieve almost exactly the same contour, which slightly smoothes out the slight kinks from this:

Before:

![](assets/2019-01-07-14-40-13.png)

After (showing the previous outlines as a background layer):

![](assets/2019-01-07-14-39-28.png)


![](assets/2019-01-07-14-57-50.png)

![](assets/2019-01-07-14-59-04.png)

Some letters have probably-unecessary points, but they don't cause issues, so I'll leave them:

![](assets/2019-01-07-15-03-59.png)

No kinks caused:

![](assets/2019-01-07-15-04-22.png)

Some unecessary control points cause lumpy curves. Here's a before-after of the `/t` (it is now a smoother curve, which better aligns to the overall design style):

![](assets/round-t.gif)

This has an unneeded point, and can be simplified without changing shape:

![](assets/2019-01-07-18-04-29.png)

![](assets/2019-01-07-18-04-56.png)

Additionally, the `/u` has an "inktrap" which is not present in almost any other character with a similar connection, like `/n`, `/m`, `/r`, etc. I'll remove it.

![](assets/inktrap-u.gif)

This `/x` has two problems:
1. unnecesary control points, with smooth brackets that are overly-pointy
2. misaligned thin stems. They should be offset in the *opposite* direction

![](assets/2019-01-07-18-21-21.png)

Fixed:

![](assets/x.gif)

Some points are not really needed and triggering an "incorrect smooth curve" notice, but not causing visible kinks or lumpy curves. I'll leave them:

![](assets/2019-01-07-18-31-08.png)

### Other issues

The `/Z` and `/z` have an inconsistent approach to these flat bits:

![](assets/2019-01-07-18-27-18.png)

Most of them are angled, while some are flat. This doesn't have a great regular/bold break, so I've made them all slightly-angled:

![](assets/2019-01-07-18-29-10.png)

The cent has no bold:

![](assets/cent.gif)

Now it does:

![](assets/cent2.gif)

The `/sterling` is lumpy and doesn't connect at the curly bit:

![](assets/2019-01-07-18-40-01.png)


Luckily, this will benefit a lot from a non-overlapped drawing.

![](assets/2019-01-08-11-04-57.png)
![](assets/2019-01-08-11-05-08.png)

I still think there may be room for improvement, here ... this whole glyph is completely oblique, rather than upright. While other Caslons on my system also have this feature, it doesn't seem like a great one to emulate, as it gives a completely imbalanced appearance.

![](assets/2019-01-08-11-13-49.png)
![](assets/2019-01-08-11-13-36.png)

This `/at` is a bit wobbly, in large part from several unnecessary points.

![](assets/2019-01-08-16-13-38.png)

It's cleaner with a few points removed:

![](assets/2019-01-08-16-15-31.png)

It goes outside my scope to fiddle with every glyph in this font, buuuut there are a few I want to touch up. 

This ampersand has curves that are a bit lumpy, and its contrast is uneven:

![](assets/2019-01-08-16-39-00.png)

It's still not perfect, but it's a little more graceful:

![](assets/2019-01-09-13-21-08.png)

A big thing that has bothered me in the Italic is the `/f`. An `/f` in this tall italic form should lean slightly back in the middle section, because without that lean-back, it will appear to lean _forward_ due to the long swashes.

Here's the original:

![](assets/2019-01-08-16-50-05.png)

And here's my revision:

![](assets/2019-01-15-15-38-24.png)

It's not a huge change, but I've made an effort to make the overall "mass" of the lette have the same overall lean of the surrounding letters. Here are the new outlines (black) over the previous outlines (in gray):

![](assets/2019-01-09-10-08-34.png)

Of course, I'll also have to bring this change into the Italic ligatures:

![](assets/2019-01-08-16-51-47.png)

To do so, I'll make non-exporting components of the `/f` and other letters needed for ligatures. This way, if further tweaks are needed later, it won't require _every_ ligature to be re-edited.

![](assets/2019-01-09-10-41-45.png)

Caslon now has an updated set of `f` ligatures. Most idiosyncrasies are retained in shapes, but the `f` form is updated, and spacing has been slightly refined.

![](assets/2019-01-09-11-51-08.png)

## Rounding Kerning

Because I interpolated the "Regular" master, I've rounded kerns to integers with GlyphsApp Freemix tools.


## Fixing tabular symbols

In the process of finding non-tabular `.tnum` glyphs in the Italic, I made a script which helped me realize that there are also several non-tabular `.tnum` glyphs in the Romans. These are the prior values, and have been updated:

| Glyph | Width |
|---|--:|
| slash.tnum | 516.0 |
| colon.tnum | 516.0 |
| period.tnum | 516.0 |
| comma.tnum | 516.0 |
| percent.tnum | 1805.0 |
| periodcentered.tnum | 516.0 |
| quotesingle.tnum | 516.0 |
| quotedbl.tnum | 516.0 |
| bar.tnum | 516.0 |
| semicolon.tnum | 516.0 |
| degree.tnum | 536.0 |

I will now adjust them.

![](assets/2019-01-08-14-56-06.png)

![](assets/2019-01-08-15-03-30.png)

![](assets/2019-01-08-15-11-18.png)

![](assets/2019-01-08-15-13-52.png)

I slightly prefer the broken-bar version, but it seems like a less-classical solution. I'll go with the latter, stacking the zeros more.


# Italic QA

## Fixing `tnum` symbols

I've noticed that quite a few glyphs in the italic are given a `.tnum` suffix, but haven't yet been modified to actually be tabular. Using some quick Python, I can find the problem glyphs:

| Glyph | Width |
|---|--:|
| slash.tnum | 516.0 |
| colon.tnum | 516.0 |
| period.tnum | 516.0 |
| comma.tnum | 516.0 |
| degree.tnum | 536.0 |
| percent.tnum | 1461.0 |
| periodcentered.tnum | 516.0 |
| yen.tnum | 1222.0 |
| equal.tnum | 891.0 |
| quotesingle.tnum | 516.0 |
| quotedbl.tnum | 516.0 |
| bar.tnum | 584.0 |
| semicolon.tnum | 516.0 |
| cent.tnum | 853.0 |
| dollar.tnum | 1007.0 |

I've updated the Python (at `sources/scripts/helpers/check-tnum-widths.py`) to also set the widths and put shapes into the middle. This is just to have a helpful starting point for making tabular glyphs.

Like the Roman `percentage.tnum`, I'll stack this one:

![](assets/2019-01-08-15-29-43.png)

I've copied in the `/yen.tnum` from roman regular, and skewed it to 22.5 degrees, made some optical adjustments, and positioned it to sit equally between tabular numerals (which is not as obvious as it might sound, because the entire italic is offset in its bounds):

![](assets/2019-01-08-15-36-38.png)

![](assets/tabular.gif)

...*actually*, this points out that the tabular numbers seem to be off. I'll have to fix those, first. With those fixed, it's more useful to take this approach.

![](assets/tabular2.gif)

Here, I am:
1. Setting up placeholder glyphs with `shift + option + cmmd + P`
1. using `t` to enter text mode to navigate between glyphs
1. pressing `esc` to re-enter edit mode, and then `cmmd + a` to select all paths to move them

## Letter shape refinements

Because I halfway-redrew the `/sterling`, I'm touching it up in the Italic before I move on. It's less messy, but still a bit drafty:

![](assets/2019-01-08-11-25-06.png)

I've used SuperTool to smooth curve connections, then adjust visually:

![](assets/2019-01-08-11-29-47.png)

![](assets/2019-01-08-11-30-04.png)

...not quitte perfect, but let me match thickness with the regular by using a background layer:

![](assets/2019-01-08-11-33-48.png)

I've also backslanted it slightly, to visually match the overall lean of the surrounding glyphs:

![](assets/2019-01-08-11-42-18.png)

...and I've adjusted the contrast to better match the sharpness of the rest of the font:

![](assets/2019-01-10-09-43-49.png)

### Diagonal stem widths

Currently, diagonal stems appear thinner than horizontals. 

![](assets/2019-01-09-13-14-25.png)

Checking the actual thicknesses, it becomes clear that diagonals are actually thinner than horizontals – which is backwards, and a common problem introduced by slanting Roman letters without corrections.

![](assets/2019-01-09-13-13-10.png)

![](assets/2019-01-09-13-13-50.png)

Process:
1. In the Roman regular weight, the ratio of horizontal to NE diagonals is 73:78, or 1.068493151.
1. The horizontal of the `/A` should match the `/H`, as they do in the Roman. So, the A bar should be 68.
1. 68*1.068493151 = 72.657534268. I'll make the NE diagonals about 73 units in thickness, adjusting this optically as I go.

![](assets/2019-01-09-13-56-21.png)

### Outline quality tweaks

The Enj doesn't quite meet up, and this would show up as a little "spur" in some context. I'll move it to the corner.

![](assets/2019-01-09-13-44-41.png)

![](assets/2019-01-09-13-43-21.png)

`/S` has an inflection ... on just one side of the spine.

![](assets/2019-01-09-13-45-59.png)

There are smooth bracket made less-smooth by having unnecessary extreme points:

![](assets/2019-01-09-13-48-27.png)

Serifs have inconsistent heights, such as in this `/W`.

![](assets/2019-01-09-13-50-10.png)

The `/g` really looks like it's falling forward, so I'll move the ear.

![](assets/2019-01-09-13-59-21.png)

![](assets/2019-01-09-14-01-33.png)

The `/t` is lumpy/pointy on the bottom, and has a bit of an inflection in the stem.

![](assets/2019-01-09-14-04-13.png)

![](assets/2019-01-09-14-04-49.png)

There are lots of little "incorrect smooth curve" points, so I'm just wiggling these anchors back and forth to make them smooth again.

![](assets/2019-01-09-14-06-05.png)

The curls on the `/z` are very imbalanced.

![](assets/2019-01-09-14-11-17.png)

I've copied the top, and made some optical corrections. This should appear a bit more balanced:

![](assets/2019-01-09-14-43-35.png)

Things don't line up in the `/eight.denominator` or `/eight.numerator`:

![](assets/2019-01-09-14-52-32.png)

So I fixed it:

![](assets/2019-01-09-14-55-49.png)

This bottom stroke isn't quite smooth:

![](assets/2019-01-10-09-49-37.png)

...so I've reconnected some nodes to help it out (yes, I'm leaving a few inflections, as there are in some of these tear-drop terminals):

![](assets/2019-01-10-09-51-08.png)

---

Libre Caslon could probably be refined even further, but for now, the outlines are a lot better off than they were! Onto the next stage of publishing this.

## Ogonek fixes

Gah! I've come across an errant ogonek to fix:

![](assets/2019-01-23-15-47-34.png)

And this was just the start of the issue.

The ogoneks were a bit of a mess – they were mostly following the principles of accents like the cedilla, being a lighter weight and generally in the middle of glyphs. However, [as Adam Twardoch says](http://www.twardoch.com/download/polishhowto/ogonek.html) and I've heard in person from Polish type designers, ogoneks should be more of a _part_ of letters, similar to parts such as the tails of a `g` or `Q`. I needed to refine their drawings, and add anchors to update their positioning. In order to stay efficient (both in input and output), I kept a component-based workflow, making 4 total components across upper and lowercase letters to account for round vs straight bottoms.

![](assets/2019-01-23-18-51-04.png)

![](assets/2019-01-23-18-51-15.png)