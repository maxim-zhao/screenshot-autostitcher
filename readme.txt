Screenshot Autostitcher
=======================

> What is it?

It takes large numbers of ordered, closely timed videogame (emulator)
screenshots and stitches them together in a pixel-perfect fashion.

> Closely timed?

Yes, ideally screenshots taken at a consistent high framerate - for example,
30fps or 60fps. This means that there should not be much difference between one
frame and the next which makes it a lot easier for a computer to figure out
exactly where they join.

In order to obtain these, I suggest you find an emulator that either supports
taking one screenshot for every frame, or that supports output to lossless AVI.

> OK, I have some images. Now how do I use it?

Open one of the images using the first [...] button. It will display how many
images it found in the sequence. Numbered filenames should be handled well.

You can stick with the default settings for now; just press the Autostitch
button and see what happens.

> Nothing happens!

If the log isn't showing, make it show and see what the error was.

> My images all smooshed into each other

That's because there were false positives. Try:

1. Increase the "Good match if >" percentage. If it's too low, bad matches are
   accepted and it gives up looking for better one. It will keep looking until
   it finds a match of at least this percentage quality, but if you set it too
   high it wastes time by searching exhaustively.
2. Your screenshots are just too similar. Maybe there's large areas of solid
   colour that confuse the algorithm. Try making them less like that, or set
   good match threshold higher again.

> I get "Discarding due to bad match" and the stitch is incomplete

That's because there were false negatives. Try:

1. Decrease the "Bad match if <" threshold. This will make it accept worse
   matches but increases the chance of errors.
2. Maybe the search distance is too small? If the screen moves very fast, or
   your screenshots are not at a very high framerate, you'll need to increase
   this. It can slow down matching a lot if set too high, especially if it is
   doing exhaustive searches due to a high "good" threshold.

> Mask?

If there's some part of your image that you don't want to be part of the
stitch, then create a "mask" image where every pixel is either white or black,
the same size as the screenshots. Make it white where you want to have the
corresponding screenshot pixel show up in the stitch and black where you want
it removed. Tick the box and select the mask image to make this all work.

> Just explain all the settings.

>>> Filename

    Should be obvious. You can choose BMP, PNG, GIF, PCX or AVI files.

    If it's an image, it will try to find all the matching files, by looking
    for a number in the filename and replacing it with a * to do a filename
    match. If there's no number, it'll pick every BMP file. It then sorts them
    carefully (so 2 comes before 10). So if you get unexpected images showing
    up, that's why.

    If it's a video, it just loads all the frames from the first video stream.
    It had better be a lossless video else it probably won't stitch well.
    DOSBox videos are lossless, and if you edit them then I suggest you encode
    to Lagarith.

>>> Mask

    White to keep, black to discard. Very useful for getting rid of status
    displays and the main sprite, if it stays near the centre of the frame.
    Colours other than black and white are not recommended.
    
>>> Crop

    If you only want to use a rectangular subsection of the frame, cropping
    might be faster than a mask. Use an image editor to get the exact pixel
    parameters.
    
    If you combine it with a mask, the mask should match the cropped image.
    
    Press Reset to reset the cropping to the full frame (note that it will
    still be slower than if you disable cropping entirely). Check the "Reset on
    load" box to have this happen every time you load a new source image/video.

>>> Frames

    You might not actually want all the images, especially if there was a
    stitching failure somewhere around the middle of the sequence but it was
    fine otherwise. So select the frame numbers here. The first frame is 0.

    Press the Reset button to reset the limits to cover all the frames. Check
    the "Reset on load" box to have this happen every time you load a new
    source image/video.

>>> Decimate by

    What if you have 60fps images of a game that runs at 15fps? Decimate by 4
    and it'll skip 3 out of 4 frames. Or maybe the stitch just goes faster this
    way.

    Note that it is slow to use this with AVI sources that use a codec that
    features intra-frame encoding (eg. DOSBox videos), because then every frame
    is obtained by a seek from the preceding keyframe.

    If you re-encode using 100% keyframes (eg. HuffYUV or Lagarith codecs) or
    extract the video to an image file sequence (takes a lot of disk space), it
    will work better.

>>> Reverse order

    Load the images in the reverse order. This has the advantage that sprites
    will generally leave remnants in the first place they appeared on-screen,
    and the player sprite will appear in the first observed position.

    This is also very slow with AVI sources using intra-frame coding. See the
    workarounds above.

>>> Search up to

    The maximum distance it will search horizontally or vertically for a match.
    Look at the logs/graphs to see if you have it set too high, because the
    higher the slower (potentially).

>>> Bad match if <

    If it tries to place an image in the wrong spot, there will be less pixels
    that match up. If the proportion matching is below this number (which can
    have decimal places if you really want) then it will think it doesn't match.
    If it's above, it will think it's an OK match.

    It tries all the positions within the pixel search distance and chooses the
    OK match with the highest matching proportion. If there are no OK matches
    then it will discard the image.

>>> Good match if >

    If the matching pixels proportion exceeds this percentage, it will think
    it's a good match. It will then give up looking for a better match. This
    greatly speeds up matching, but must be high enough to avoid false
    positives.

>>> Scrolling goes

    Reduce the search space by changing this. Less search space = faster.

>>> Expand in

    When the current work area gets too small, this is how much bigger to make
    it. Size changes are very slow. Make this number large to avoid many
    changes, at the cost of having more wasted space around the result (which
    you're going to crop anyway).

>>> Drop 0,0 matches

    If a frame matches at exactly the same position as the one before it, this
    will make the program act as if it was not there at all. This can improve
    stitch performance.

>>> Background fill

    Type in a 6-digit hex code (like HTML/CSS) to choose a colour. The border
    of the preview box turnd black when it's valid. This colour will be used to
    fill all of the "background" when you save or copy. It won't show in the
    program to avoid hurting your eyes. Make sure to choose a colour that does
    not appear in the map.

>>> Graph

    The green line is the stitch quality, aka percentage of pixels matched. The
    top of the graph is 100%, the first grey line is 90%, and the bottom of the
    graph is 80%. Lower values aren't shown; you should be aiming to have
    values at the top of the graph anyway. Bad matches are likely to show up as
    spikes.

    The red line is the X movement. The blue line is the Y movement. These help
    you see how smooth the motion is. Smooth motion is easier to stitch. Also,
    bad matches may show up as spikes.

>>> Log

    It's partly for me (debugging) and partly for you (feedback on how the
    stitch is going). Turn it on while you get your parameters set up, or if
    you are getting errors. Turn it off to speed up stitching.

>>> Follow stitch

    Check this and the view will automatically scroll so the current "action"
    is visible. Turn this off to make it go slightly faster.

>>> Autostitch

    Does the work. You can press it again to cancel the stitch halfway (it
    might take a while to respond if the stitch is slow).

>>> Save

    Save the stitched image to disk.

>>> Copy

    Copy the stitched image to the clipboard.

> It gives an error when the bitmap gets really big.

Yes, it does. It seems the exact limit depends on your graphics card drivers,
Windows version and the phase of the moon. Watch the status bar to see how big
the image is. On my computer, the limit's somewhere around 300MB. If your map
is larger than that, then stitch it in sections and merge them in a dedicated
image editor.

> Can I see the source?

Maybe. It's Delphi (7), and it's ugly hacks on top of kludges on top of a huge
mess. I might release it, I might not.

> Libraries?

graphics32 by the fine people at graphics32.org gives me simpler masking and
bigger images.

vidframe.dll by aquaplaning gives me video.

GraphicEx by Mike Lischke gives me support for other file formats.

> And you are?

maxim # smspower , org
