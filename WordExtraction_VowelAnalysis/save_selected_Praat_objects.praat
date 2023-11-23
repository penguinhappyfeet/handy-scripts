# Save Selected Praat Objects
# This script exports user-selected .wav files and .TextGrids to a directory chosen by the user.
# Updated: 2023-03-09 by Chierh Cheng

# User selects output directory
pause Choose a directory to save your files
directory$ = chooseDirectory$ ("Choose a directory to save")
directory$ = directory$ + "/"

# Prompt the user to select TextGrid objects to be saved
pause Select TextGrids to be saved before clicking on Continue
numberOfSelectedTextGrids = numberOfSelected("TextGrid")

# Store the selected TextGrid objects in an array for later processing
for i to numberOfSelectedTextGrids
	tg_object[i] = selected("TextGrid", i)
endfor

# Iterate through the array of selected TextGrid objects and save each one to the chosen directory
for i to numberOfSelectedTextGrids
	selectObject(tg_object[i])
	name$ = selected$("TextGrid")
	Save as text file... 'directory$''name$'.TextGrid
endfor

# Prompt the user to select Sound objects to be saved
pause Select Sounds to be saved before clicking on Continue
numberOfSelectedSounds = numberOfSelected("Sound")

# Store the selected Sound objects in an array for later processing
for i to numberOfSelectedSounds
	sound_object[i] = selected("Sound", i)
endfor

# Iterate through the array of selected Sound objects and save each one to the chosen directory
for i to numberOfSelectedSounds
	selectObject(sound_object[i])
	name$ = selected$("Sound")
	Save as WAV file... 'directory$''name$'.wav
endfor

writeInfoLine("All selected objects are saved in the end directory.")

