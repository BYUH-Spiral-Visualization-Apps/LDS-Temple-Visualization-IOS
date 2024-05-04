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

### In templeLinks folder:
1. For each temple you add to the project, make sure you add the link for it in the templeLinks Folder. The project will crash if there are less lines(temple links) in the templeLinks Folder than in the TemplesFilesNames Folder.

### In assets folder:
1. For each temple with a picture, add two images: a 200x200 circle cropped image to the small_circles folder, and a 500x500 circle cropped image to the large_circles folder. PNG file is recommended.
2. If there is no offical photo or rendering of the temple that comes from one of the official church websites, make placeholder instead. Canva is a great online tool to make these images. Refer to other temples with placeholders to get an idea of how it should look like.
   
Example naming convention for large circle: salt_lake_city_temple_large
Example naming convention for small circle: salt_lake_city_temple

### In AllTemplesInfo folder:
1. If you use Finder, you will see that three folders live inside of AllTemplesInfo (Base.lproj, en.lproj, zh-Hans.lproj). In each of these folders, you will need to create a new file for each new temple following naming conventions in those folders. A command line tool may make this job faster than doing it by hand. When naming these files, do not include any special characters. For example, Maceió Brazil Temple file should be named "maceio_brazil_temple" Make sure your temple file name is EXACTLY the same way it is spelled in the templesFilesNames folder, or else the program wont be able to find your corresponding files.


Updated until October 2023 General Conference
