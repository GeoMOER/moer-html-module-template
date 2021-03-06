---
title: "Example: Setting up the Working Environment"
toc: true
toc_label: In this example
---



Setting up a working or project environment requires the definition of different folder pathes and the loading of necessary R packages and additional functions. If additional software like GIS should also be accessible, respective binaries and software environments must be linked, too.

For setting up a project environment, one can use a set-up script and the
envimaR and link2GI packages. 


## Preliminary consideration
There are two aspects we would draw your attention to:
1. Define everything once not twice: It is a good idea to define your project
folder structure, the required libraries and other settings in one place. A simple
approach would be a setup script, i.e. something like `000_setup.R` that is sourced
into each control or analysis script of your project.
1. Use the same project folder structure in a team: Use the same folder structure
relative to a fixed starting point across all computers and devices of your team.
As a starting point, a folder in your home directory  (e.g. `~/edu`) is a good choice.
Within this folder you can directly store your projects or use a symlink to any
other place on your storage devices. 1


## Special considerations at our computer labs
The R home directory on the computers in the labs at Marburg University points to
the network drive `H:/Documents`. For other but unkown reasons, you could not use
this drive for symlinks (the links work, but they get in conflict with storage
space restrictions). Therefore, you have to define an alternative starting point
for your project folders to work with.

To handle your project relative on all computers using something beneath your 
home directory `~` as a starting point except on one type of computer (i.e. the
ones in the University computer labs), we reccomend to use the functionality of
the envimaR package.


## Templates
For the following we assume that 
* your local starting point is `~/edu`,
* your project is called `mpg-envinsys-plygrnd`,
* your git repository is called `name_of_github_team_repository`,
* your setup script is called `000_setup.R` and is located at `name_of_github_team_repository/src`.

The required envimaR package can be installed from GitHub.

```r
devtools::install_github("envima/envimaR")
```


### Template for sourcing the setup script
To source the setup script you should reference its location in the same manner 
as any other folder/file. Therefore, include something like this into the header
of your control or analysis scripts.

```r
# Source setup script ----------------------------------------------------------
library(envimaR)
root_folder = alternativeEnvi(root_folder = "~/edu/mpg-envinsys-plygrnd", 
                              alt_env_id = "COMPUTERNAME",
                              alt_env_value = "PCRZP", 
                              alt_env_root_folder = "F:\\BEN\\edu")
source(file.path(root_folder, "name_of_github_team_repository/src/000_setup.R"))
```


### Template for setup script

```r
# Set project specific subfolders
project_folders = c("data/",                                 # data folders
                    "data/aerial/org/", "data/lidar/org/", "data/grass/", 
                    "data/data_mof", "data/tmp/", 
                    "run/", "log/",                          # bins and logging
                    "name_of_github_team_repository/src/",   # source code
                    "name_of_github_team_repository/doc/")   # markdown etc. 

# Set libraries
libs = c("link2GI", "raster", "rgdal", "sp")


# Automatically set root direcory, folder structure and load libraries
envrmt = createEnvi(root_folder = "~/edu/mpg-envinsys-plygrnd", 
                    folders = project_folders, 
                    path_prefix = "path_", libs = libs,
                    alt_env_id = "COMPUTERNAME", alt_env_value = "PCRZP",
                    alt_env_root_folder = "F:\\BEN\\edu")
```
One can now access the respecive sufolders using the list entries of the variable `envrmt`. The entries are named according to the subfolder names with the prefix "path_".

```r
print(envrmt$path_data_mof)
```

```
## [1] "C:/Users/tnauss/Documents/edu/mpg-envinsys-plygrnd/data/data_mof"
```

If the `raster` package has been loaded, it is a good choice to set the temp directory to the one of the just defined project environment. Therefore include the following in the setup script.

```r
rasterOptions(tmpdir = envrmt$path_tmp)
```


### Linking GIS software
If required, on can now go on in the setup script and link selected GIS software etc. using the link2GI package. This generaly starts looking for the respective installations (in case one does not know all the details). 

```r
# Link GIS software ------------------------------------------------------------
# Find GRASS installations
grass_path = findGRASS()

# Find SAGA installations
saga_path = findSAGA()

# Find OTB installations
otb_path = findOTB()
```
