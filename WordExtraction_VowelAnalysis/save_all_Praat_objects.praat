# Save All Praat Objects
# This script exports all .wav files and .TextGrids present in the Praat Objects window to a user-specified directory.
# Last Updated: 2023-03-16 by Chierh Cheng

# Prompt the user to choose a directory for saving the output files
pause Choose a directory to save your files
dir$ = chooseDirectory$ ("Choose a directory to save")
dir$ = dir$ + "/"

select all

# Determine the total number of selected sound objects in the Praat Objects window. Then, iterate through each sound object, saving them individually to the specified directory.
n = numberOfSelected("Sound")
for counter from 1 to n
	select selected("Sound",'counter')
	name$ = selected$ ("Sound")
	Write to WAV file... 'dir$''name$'.wav
	select all
endfor

# Determine the total number of selected TextGrids in the Praat Objects window. Then, iterate through each TextGrid, saving them individually to the specified directory.
t = numberOfSelected("TextGrid")
for counter from 1 to t
	select selected("TextGrid",'counter')
	name$ = selected$ ("TextGrid")
	Write to text file... 'dir$''name$'.TextGrid
	select all
endfor

writeInfoLine: "All objects saved in the end directory." 