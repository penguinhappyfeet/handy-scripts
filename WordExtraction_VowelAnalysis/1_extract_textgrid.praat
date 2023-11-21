# This script searches for a target word in a specific tier and extracts the relevant part. (Created by Chierh Cheng on 2023-04-03)

# Steps to use this script:

# 1) Create a folder named after the target word, e.g., "foo".

# 2) Place the unextracted TextGrid files into the folder created in step 1. For example, file1.textgrid, file2.textgrid, etc.

# 3) Run this script. In the form that pops up in Praat, input the word to be searched (target_word) and the tier number to be searched from (target_tier).

# 4) Select the directory from which to read the TextGrid files.

# 5.1) If no word is found in the target tier, a Praat message 'No row matches criterion' will pop up. Click on OK to continue.
# 5.2) The Praat Info will append the names of TextGrid files in which the target_word is not found in the target_tier.

# 6) In the Praat Objects window, review and save the found (extracted) TextGrid objects.
# Use the scripts save_selected_Praat_objects.praat or save_all_Praat_objects.praat as needed.

# 7) Proceed to extract sound files using the script extract_sound_praat.

# Form to request specific information from the user for script execution
form
	# Note: TextGrid files can have either .TextGrid or .textgrid as their extension.
	word TextGrid_extension .textgrid
	comment Which tier is used for word search (default 3, Morphology tier)?
	positive target_tier 3
	comment Target word to search for
	text target_word balmuk
endform

pause Choose a directory to read textgrid files from
directory$ = chooseDirectory$ ("Choose a directory to read files from")
directory$ = directory$ + "/"

# Read all TextGrid files
# This creates a "Strings list" object that contains only .TextGrid files
strings = Create Strings as file list: "list", directory$ + "*" + textGrid_extension$
nFiles = Get number of strings


# Read TextGrid files into the Praat Objects window
for i to nFiles
	selectObject: strings
	fileName$ = Get string: i
	baseName$ = fileName$ - textGrid_extension$
	tgName$ = baseName$ + textGrid_extension$
	Read from file: directory$ + tgName$
endfor

select all

# Store the original selection of files in arrays
for i to nFiles
	#sound_object[i] = selected("Sound", i)
	tg_object[i] = selected("TextGrid", i)

	# This will be used later to rename the extracted target_tier and its table, to match the original TextGrid names
	targetTierName$[i] = selected$("TextGrid",i) + "_" + "target_tier"
	

endfor

# Begin extraction of TextGrids based on the search criteria
for i to nFiles
	
	selectObject(tg_object[i])
	current_tg_object = selected("TextGrid")

	do("Extract one tier...", target_tier); target_tier is extracted as a TextGrid object
	do("Rename...", targetTierName$[i])
	
	do("Down to Table...", "no", 6, "yes", "no"); now Table object based on the extracted target_tier is selected
	do("Extract rows where column (text)...", "text", "contains", target_word$); now Table of the target word only is selected

	currentTable = selected("Table")

	nrow = do("Get number of rows"); how many occurrneces of the target word in the target_tier

	# Handle cases where the target_word appears multiple times in the target_tier
	if nrow > 1
		for j from 1 to nrow
			
			tminValue = do("Get value...", j, "tmin")
			tmaxValue = do("Get value...", j, "tmax")

			select current_tg_object
				
			extracted_tgNames$ = selected$("TextGrid") + "_" + target_word$ + "_" + string$(j)

			do("Extract part...", tminValue, tmaxValue, "no")
			do("Rename...", extracted_tgNames$)
			
			select currentTable

		endfor

	# Handle the case where the target_word appears only once in the target_tier
	elsif nrow = 1
			tminValue = do("Get value...", 1, "tmin")
			tmaxValue = do("Get value...", 1, "tmax")

			select current_tg_object
			extracted_tgNames$ = selected$("TextGrid") + "_" + target_word$ + "_" + "1"
			do("Extract part...", tminValue, tmaxValue, "no")
			do("Rename...", extracted_tgNames$)

	# Handle the case where the target_word does not exist in the target_tier
	elsif nrow = 0
			select current_tg_object
			extracted_tgNames$ = selected$("TextGrid")

			appendInfoLine(extracted_tgNames$, ": ", target_word$, " is not in the serached tier ", target_tier)

	endif
	
endfor