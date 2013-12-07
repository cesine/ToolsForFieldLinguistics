# Draw formant chart from segments in the sound files of a specified directory
# Sound files must be .aif or .wav
# TextGrid files must be .textgrid
#
# This script is distributed under the GNU General Public License.
# Copyright Mietta Lennes 13.3.2002
# Edited by Gina Cook
# v4 changed graph labels
# v5 relativized version of 4 using f1 plotted against f2-f1
# v6 changed formant tracking method per male and female
# v7 Nov 2010 added specific colors for specific segments


form Draw a vowel chart from the centre points of selected segments, open the textgrid, wav, segments and wave files you want
comment Give the name of the pair:
text filename vowels-english-canada-female
choice MaleFemale 2
button Male
button Female
comment Which tier of the TextGrid files should be used for analysis?
integer Tier 1 
#comment Which segments should be analysed?
#sentence Segment_label a
#comment Where would you like to save the results?
#text resultfile results.txt
comment Formant analysis options
positive Time_step 0.01
integer Max_number_of_formants 5
#positive Maximum_formant_(Hz) 4500 (=adult male4500, 5500= adult female)
positive Window_length_(s) 0.025
positive Preemphasis_from_(Hz) 50
choice Picture 1
button Erase the Picture window before drawing
button Overlay the old picture 
choice Debug 1
button Print vowel label
button Print vowel times
endform

if maleFemale = 1 
    maximum_formant = 4500
else if maleFemale = 2 
    maximum_formant = 5500
endif

# Prepare the Picture window and draw a chart grid for formant analysis:
if picture = 1
	Erase all
endif
Viewport... 0 6 0 6
Font size... 12
Line width... 1
Viewport... 0 6 0 6
# To Change the Axes: Xmin Xmax Ymin Ymax
# For pure F1,F2 head oriented towards the left:
Axes... 3000 600 1000 100 
# For relativized as F1 against F2-F1, head oriented towards the left
# Axes... 2300 250 900 200
Text top... yes Vowel Space
Text bottom... yes Front --------- F_2 (Hz) --------- Back
Text left... yes  Low --------- F_1 (Hz) --------- High
Font size... 12
Marks bottom every... 1 500 yes yes yes
Marks left every... 1 100 yes yes yes
Plain line

token = 0 
# this is a "safety margin" (in seconds) for formant analysis, in case the vowel segment is very short:
margin = 0.02


#Can uncomment if you want to know whether the pair were opened
#printline Opened Sound and TextGrid... 'filename$'
	call Measurements

#printline 'filename$'
#printline The (F1,F2) formant points of 'token' tokens of segment "'segment_label$'" were plotted on the chart. 





#----------------------
procedure Measurements



#make a string for colors and for segments
#depends on: load the colors.strings file
# select Strings colors
# numberOfColors = Get number of strings
# color$ = Get string... 1 
select Strings segments
numberOfSegments = Get number of strings
#segment_label$ = Get string... 1

for segIndex to numberOfSegments
	select Strings segments
	segment_label$ = Get string... segIndex

        select Strings colors
	color$ = Get string... segIndex
	'color$'
	#printline 'segment_label$' is 'color$'


# look at the TextGrid object
select TextGrid 'filename$'
numberOfIntervals = Get number of intervals... tier
filestart = Get starting time
fileend = Get finishing time

for interval to numberOfIntervals

select TextGrid 'filename$'
label$ = Get label of interval... tier interval
if label$ = segment_label$
	token = token + 1
	segstart = Get starting point... tier interval
	segend = Get end point... tier interval

	# Create a window for analyses (possibly adding the "safety margin"):
	if (segstart - margin) > filestart
		windowstart = segstart - margin
	else
		windowstart = filestart
	endif	
	if (segend + margin) < fileend
		windowend = segend + margin
	else
		windowend = fileend
	endif	
	segduration = segend - segstart
	
	select Sound 'filename$'
	Extract part... windowstart windowend Rectangular 1 yes
	Rename... window
			
	# measure F1 and F2
	select Sound window
	To Formant (burg)... time_step max_number_of_formants maximum_formant window_length preemphasis_from
	Rename... formants
	# Note: the Track command only makes sense if you have a continuous vowel segment that
	# you think should have a fixed number of formants.
        # added by gina, tried to create tracks for male vs female (lowered values by 200hz) it works, but not sure if its accurate.
	if maleFemale = 1 
              Track... 3 350 1450 2550 3650 4750 1 1 1
        else if maleFemale = 2 
              Track... 3 550 1650 2750 3850 4950 1 1 1
        endif
	Rename... formanttracks
	measurepoint = (segstart + segend) / 2
	vowF1 = Get value at time... 1 measurepoint Hertz Linear
	vowF2 = Get value at time... 2 measurepoint Hertz Linear
	Viewport... 0 6 0 6



	Draw circle... vowF2 vowF1  50
	# if you want a vowel symbol drawn in the middle of each vowel circle, leave the next line untouched:
	#if to print the vowel label or the vowel times (in order to go back in the text grid and see why the formant measurements are so far off from the expected vowel quality
        if debug = 1
                Text... vowF2 Centre vowF1 Half 'segment_label$'
	else if debug = 2
	        Text... vowF2 Centre vowF1 Half 'segstart'
	endif
	
	# remove the Sound object of the analysed segment
	select Sound window
	Remove
	# now we have to remove the original Formant object
	select Formant formants
	Remove
	# and also the second Formant object that was created by the Track command
	select Formant formanttracks
	Remove
endif

endfor

#to loop through the segments
endfor 

endproc


