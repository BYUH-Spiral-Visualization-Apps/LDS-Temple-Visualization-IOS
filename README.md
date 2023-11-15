# LDS-Temple-Visualization-IOS
IOS version of the LDS Temples Visualization App 

# Instructions for maintenance

## Adding new temples: 

### In TemplesNamesYears folder:
1. Append newly announced temples to the end of the base list, and on the next line type "1111". This is a placeholder for the dedication year. 
2. If any temples have been dedicated since the last update, change the number beneath the name to the proper year. 
3. Repeat these steps for the English file (and Chinese file if you are able).

### In LDS-Temple-Visualization-IOS/templeFilesNames:
1. Add a new file name for each newly announced temple following the format in the file. 

### In assets folder:
1. For each temple with a picture, add two images: a 200x200 circle cropped image to the small_circles folder, and a 500x500 circle cropped image to the large_circles folder. 

### In AllTemplesInfo folder:
1. If you use Finder, you will see that three folders live inside of AllTemplesInfo (Base.lproj, en.lproj, zh-Hans.lproj). In each of these folders, you will need to create a new file for each new temple following naming conventions in those folders. A command line tool may make this job faster than doing it by hand.

Updated until 2021 October General Conference
