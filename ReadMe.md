# Welcome to the Brass Quintet Music Book Generation ReadMe File!

## Contents
- 1 -  What does it do?
    - 1.1 - Project Layout
    - 1.2 - Description of Project Components
    - 1.3 - Generate Books by Genre
    - 1.4 - Generate Books by Instrument
    - 1.5 - Generate Books by both Instrument and Genre

- 2 - How to use it
    - 2.1 - Generate Books by Genre
    - 2.2 - Generate Books by Instrument
    - 2.3 - Generate Books by both Instrument and Genre
    - 2.4 - Adding New Music

## 1) What does it do?
The purpose of this project is to organize Brass Quintet music in a standardized fashion and to automate the generation of different sets of music for people who are using this Library. 

#### 1.1) Project Layout
```
Brass Quintet Music
└─── Books
│   └─── Generated Book 1
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
│   └─── Generated Book 2
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
│   
└─── Library
│   └─── Genre 1
│   |   └───  Song 1
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
│   |   └───  Song 2
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
│   └─── Genre 1
│   |   └───  Song 1
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
│   |   └───  Song 2
│       │   file1.pdf
│       │   file2.pdf
│       │   ...
|
└─── New Music
|   └───  Song 1
│   |   file1.pdf
│   |   file2.pdf
│   |   ...
|   └───  Song 2
│   |   file1.pdf
│   |   file2.pdf
│   |   ...
ReadMe.md
└─── src
|   |   generateBooks.sh
```

### 1.2) Description of Project Components:

**Books**: Contains the newly generated Books. Anytime a book is re-generated, it will be rewritten.

**Library**: Contains folders for each genre supported. Within each of these genre folders are song folders, each containing .pdf files only. **Do not add music directly to this directory**. First add it two the directory **New Music**.

**New Music:** This contains music that hasnt yet been added to the directory

**ReadMe.md**: This file.

**src**: Contains the file `generateBooks.sh`, the only source code for this project.

### 1.3) Generate Books By Genre
This option will generate a directory named **<genre_name_goes_here>_books** inside the directory **Books**. Inside the newly made directory will be created instrument specific subdirectories containing all songs of a given genre for a given instrument. 

Example: Generating Books for genre `Wedding`:
```
Books
│   └─── Wedding_Books
|   |   └─── bone_Wedding_book
│   |   |   file1.pdf
│   |   |   file2.pdf
│   |   |   ...
|   |   └─── horn_Wedding_book
│   |   |   file1.pdf
│   |   |   file2.pdf
│   |   |   ...
|   |   └─── tpt1_Wedding_book
│   |   |   file1.pdf
│   |   |   file2.pdf
│   |   |   ...
|   |   └─── tpt1_Wedding_book
│   |   |   file1.pdf
│   |   |   file2.pdf
│   |   |   ...
|   |   └─── tuba_Wedding_book
│   |   |   file1.pdf
│   |   |   file2.pdf
│   |   |   ...
```
### 1.4) Generate Books by Instrument
This option will generate a directory named **<instrument_name_goes_here>_book** inside the directory **Books**. This directory will contain all music for a given instrument. 

Example: Creating the book for instrument `Tuba`.
```
Books
│   └─── Wedding_Books
|   |   └─── tuba_book
│   |   |   file1.pdf
│   |   |   file2.pdf
|   |   |   ...
```

### 1.5) Generate Books by both Instrument and Genre
This option will generate a directory named **<instrument_name_goes_here>_<genre_name_goes_here>_book** inside the directory **Books**. This directory will contain all music for a given instrument in a given genre. 

Example: Creating the book for instrument `Horn` and genre 'Pop/Jazz'.
```
Books
│   └─── horn_Wedding_Books
|   |   file1.pdf
|   |   file2.pdf
|   |   ...
```


## 2) How to use it
In general, this should be fairly straightforward to use. Knowing that most people who use this won't be super comfortable with the Command Line, the most difficult part will most likely be running the script `generateBooks.sh`. If you already know how to run a bash script, you don't need these section. 

To run the bash script `generateBooks.sh`, one needs to navigate to the **src** directory in the Command Line (ex: Terminal). For MacOS users, follow these steps. For Windows users, go buy a Mac and *then* follow these steps:
- Open up Spotlight Search by pressing `⌘` + `Space` at the same time.
- Type "Terminal" and hit `return` or `enter` to open the terminal. 
- In Finder, navigate to the **src** directory. 
- Write the `cd` in the terminal
- Drag the **src** folder into the terminal. It should now say something like:
`some_stuff$ cd some_other_stuff/Brass\ Music/src`
- Hit `enter` or `return`. This will change directory (the cd command) to the directory **src**.
- Finally, to run the script type the following into the Terminal:
`./generateBooks.sh`. Hit `enter` or `return` and follow the promts. 
- If at any point during the program you want to exit, simply press `control` + `c` in the Terminal.

### 2.1) Generate Books By Genre
After the script `generateBooks.sh` has started, answer "g" to the first prompt. Enter your desired genre at the second prompt. The generated books will show up in the **Books** directory. 

### 2.2) Generate Books by Instrument
After the script `generateBooks.sh` has started, answer "i" to the first prompt. Enter your desired instrument at the second prompt. The generated books will show up in the **Books** directory. 

### 2.3) Generate Books by both Instrument and Genre
After the script `generateBooks.sh` has started, answer "b" to the first prompt. Enter your desired instrument at the second prompt, and your desired genre at the third prompt. The generated books will show up in the **Books** directory. 

### 2.4) Add New Music
**Do *NOT* add new music directly to the directory "Library"**. Add all new music to the directory **New Music**. To ensure that everything stays correctly formatted make sure to adhere to the project layout detailed in Section 1.1. 

Please make sure all directories containing music for a given song follow the naming convention:
`title - composer`

Please make sure all files are pdfs and that they follow the naming convention:
`instrument - title.pdf`
or 
`instrument - title - genre.pdf`
where `instrument` is tpt1, tpt2, horn, bone, or tuba.

**Failure to follow project layout (Section 1.1) and naming convention (Section 2.4) will render the script `generateBooks.sh` useless!**
