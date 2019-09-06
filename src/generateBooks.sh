#!/bin/bash


#################################################################################################
#################################################################################################
##																							   ##
##										Global Variables							   	       ##
##																							   ##
#################################################################################################
#################################################################################################
# Boolean values used to determine what the user wants to do
instrument=false
genre=false
instrument_name=""
genre_name=""


#################################################################################################
#################################################################################################
##																							   ##
##										User Interaction							   		   ##
##																							   ##
#################################################################################################
#################################################################################################
# Tell the user what this program is about and prompt them about their intent
echo ""
echo "Welcome to the new and improved Brass Music Database!"
echo ""
echo "This program has the ability to generate music books for any given instrument in a brass quintet, or for any genre of music in the data base, or for both. \
Generating a book for a certain instrument will generate a directory and fill it with all the music for a given instrument. \
Generating books for a certain genre will generate a directory and fill it with sub-directories containing music for each instrument. \
If you want to generate the book for a given instrument and a given genre, it can also do that."
echo ""

# Loop indefinitely until the user enters a valid option for what to do with the program
continue=true
while [ $continue = true ]; do
	echo "Enter 'i' to generate a book for an instrument, 'g' to generate a book for a genre, or 'b' to generate a book for both an instrument and a genre."
	read answer1
	if [ ! -z $answer1 ]; then
		if [ $answer1 = "i" ] || [ $answer1 = "g" ] || [ $answer1 = "b" ] ; then
			if [ $answer1 = "i" ]; then
				instrument=true
			elif [ $answer1 = "g" ]; then
				genre=true
			else
				instrument=true
				genre=true
			fi
			continue=false
		else 
			echo "Invalid option."
		fi
	fi
	echo ""
done

# Loop indefinitely until the user enters a valid option for what instrument to generate a book for
continue=true
while [ $continue = true ]; do
	if [ $instrument = true ] ; then
		echo "What instrument would you like to generate a book for? Enter and of the following:"
		echo ""
		echo "  - tpt1"
		echo "  - tpt2"
		echo "  - horn"
		echo "  - bone"
		echo "  - tuba"
		echo ""
		read answer2
		if [ ! -z $answer2 ]; then
			if [ $answer2 = "tpt1" ] || [ $answer2 = "tpt2" ] || [ $answer2 = "horn" ] || [ $answer2 = "bone" ] || [ $answer2 = "tuba" ]; then
				instrument_name=$answer2
				continue=false
			else
				echo "Invalid instrument."
			fi
		fi
	else
		continue=false
	fi
	echo ""
done

# Loop indefinitely until the user enters a valid option for what genre to generate a book for
continue=true
while [ $continue = true ]; do
	if [ $genre = true ] ; then
		echo "What genre would you like to generate a book for? Enter any of the following:"
		echo ""
		echo "  - Army"
		echo "  - Ceremonial"
		echo "  - Church"
		echo "  - Classical"
		echo "  - Holiday"
		echo "  - Latin"
		echo "  - Musicals"
		echo "  - Pop/Jazz"
		echo "  - Quintet"
		echo "  - Traditional"
		echo "  - Wedding"
		echo ""
		read answer3
		if [ ! -z $answer3 ]; then
			if [ $answer3 = "Army" ] ||[ $answer3 = "Ceremonial" ] ||[ $answer3 = "Church" ] ||[ $answer3 = "Classical" ] ||[ $answer3 = "Holiday" ] ||[ $answer3 = "Latin" ] ||[ $answer3 = "Musicals" ] ||[ $answer3 = "Pop/Jazz" ] ||[ $answer3 = "Quintet" ] ||[ $answer3 = "Traditional" ] ||[ $answer3 = "Wedding" ]; then
				genre_name=$answer3
				continue=false
			else
				echo "Invalid genre."
			fi
		fi
	else 
		continue=false
	fi
done
echo ""

# Display what is being generated for the user, and set the name of the directory to make
directory_name=""
if [ $instrument = true ] && [ $genre = true ]; then
	echo "Generating $instrument_name book of $genre_name songs..."
	directory_name=$instrument_name"_"$genre_name"_book"
elif [ $instrument = true ]; then
	echo "Generating $instrument_name book..."
	directory_name=$instrument_name"_book"
elif [ $genre = true ]; then
	echo "Generating $genre_name book..."
	directory_name=$genre_name"_books"
fi


#################################################################################################
#################################################################################################
##																							   ##
##										Directory Modifications							   	   ##
##																							   ##
#################################################################################################
#################################################################################################
# If the directory already exists, delete it and tell the user. First go to the 'Books' directory.
cd ../Books
directory_present=$(ls | grep $directory_name)
if [ ! -z $directory_present ]; then
	echo "Removing previously existing directory $directory_name..."
	rm -rf $directory_name
	echo "   Complete!"
fi

# Make the new directory and tell the user. Make subdirectories if we are doing genre ONLY
echo "Making new directory $directory_name..."
mkdir $directory_name
echo "   Complete!"
if [ $instrument = false ] && [ $genre = true ]; then
	echo "Making instrument subdirectories..."
	cd $directory_name
	mkdir "tpt1_"$genre_name"_book"
	mkdir "tpt2_"$genre_name"_book"
	mkdir "horn_"$genre_name"_book"
	mkdir "bone_"$genre_name"_book"
	mkdir "tuba_"$genre_name"_book"
	cd ..
	echo "   Complete!"
fi

# Go to the Library directory. If we are only doing a certain genre, go to that genre directory
cd ../Library
if [ $genre = true ]; then
	cd $genre_name
fi


#################################################################################################
#################################################################################################
##																							   ##
##										File Processing									   	   ##
##																							   ##
#################################################################################################
#################################################################################################
# Iterate through each genre directory
echo "Copying files to directories..."
for directory in *; do
	
	# Go into the genre directory
	cd "$directory"

	# Iterate through each subdirectory
	for file in *; do

		# If only concerned about instrument
		if [ $instrument = true ] && [ $genre = false ]; then
			# In this specific case, we will be in a song directory, and we need to go into it
			cd "$file"
			# Go through all files in that song directory
			for subfile in *; do
				if [[ $subfile == *"$instrument_name"* ]]; then
					cp "$subfile" "../../../Books/$directory_name"
				fi
			done
			# Go back
			cd ..

		# If only concerned about genre, copy each of the files into the book directory
		elif [ $instrument = false ] && [ $genre = true ]; then
			if [[ $file == *"tpt1"* ]]; then
				cp "$file" "../../../Books/$directory_name/tpt1_"$genre_name"_book"
			elif [[ $file == *"tpt2"* ]]; then
				cp "$file" "../../../Books/$directory_name/tpt2_"$genre_name"_book"
			elif [[ $file == *"horn"* ]]; then
				cp "$file" "../../../Books/$directory_name/horn_"$genre_name"_book"
			elif [[ $file == *"bone"* ]]; then
				cp "$file" "../../../Books/$directory_name/bone_"$genre_name"_book"
			elif [[ $file == *"tuba"* ]]; then
				cp "$file" "../../../Books/$directory_name/tuba_"$genre_name"_book"
		fi

		# If concerned about instrument AND genre, handle files accordingly
		elif [ $instrument = true ] && [ $genre = true ]; then
			if [[ $file == *"$instrument_name"* ]]; then
				cp "$file" "../../../Books/"$instrument_name"_"$genre_name"_book"
			fi
		fi
	done

	# Go back to Library Directory
	cd ..
done
echo "   Complete!"
echo ""


#################################################################################################
#################################################################################################
##																							   ##
##											Fin.										   	   ##
##																							   ##
#################################################################################################
#################################################################################################