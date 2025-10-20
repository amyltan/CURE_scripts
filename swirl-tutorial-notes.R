# If you have not installed Swirl, delete the hashmark on this line and run it.
#install.packages("swirl") 

# To set your working directory: 
setwd("~/Desktop/R/any/other/nested/folder/names") #syntax for Mac 
setwd("c:/Documents/my/working/directory") #syntax for Windows

# The working directory is what R considers "home" and it will look for and save files here.
# You'll want to store both R scripts and data sheets here. If you move these, you'll need to change the working directory line accordingly. 

# To load swirl from your packages library: 
library("swirl") 
#The program will begin to give you prompts. Follow the prompts that show (print) in the console.
#You can type and hit "run" or "command-Enter" in the script window or type directly into the console and hit "enter" to run. 
swirl()

# When asked what course you'd like to install, choose "1: R Programming: The basics of programming in R"
# Once course is installed successfully, chose 1 to enter course. 

# Swirl will give you a list of lessons within this course. 
# Work your way through lessons 1 - 7. When you've finished lesson 7, I'll give you a simplified data set to start learning how to work with morphology data. 
# The other lessons do have some good info and you can continue to work on them at your leisure. There are also other courses available that have more advanced info.

# If, at any point, R gives you an "ERROR" and tells you it's leaving swirl: 
# Type swirl() to resume. 
# Signing back in will give you the option to continue your lesson. It will pick up where you left / aborted. 

# If you ever want to jump to something different, use swirl() to return to main directory 
# Sign back in. 
# 1 will be the continuation of whatever you left off doing 
# 2 will allow you to return to the main list again.

# Swirl will remember your progress, even between R sessions (i.e. exiting the program). Just log back in with the same name. 

# To reference more information: 
#info()  #returns the following information. delete the hash to run.
#| When you are at the R prompt (>):
#  | -- Typing skip() allows you to skip the current question.
#| -- Typing play() lets you experiment with R on your own; swirl will ignore what
#| you do...
#| -- UNTIL you type nxt() which will regain swirl's attention.
#| -- Typing bye() causes swirl to exit. Your progress will be saved.
#| -- Typing main() returns you to swirl's main menu.
#| -- Typing info() displays these options again.


