#### IMPORT 3D PRINTER DATA ####
printer <- read.csv("printer.csv")
printer$timestamp <- as.POSIXct(printer$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT LASER CUTTER DATA ####
laser <- read.csv("laser.csv", header=TRUE)
laser$timestamp <- as.POSIXct(laser$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT ROOM DATA ####
room <- read.csv("room.csv", header=TRUE)
room$timestamp <- as.POSIXct(room$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT CNC DATA ####
cnc <- read.csv("cnc.csv", header=TRUE)
cnc$timestamp <- as.POSIXct(cnc$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT SURVEY DATA ####
survey <- read.csv("survey.csv", header=TRUE)
survey$timestamp <- as.POSIXct(survey$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT SCREENSHOT DATA ####
screenshots <- read.csv("screenshots.csv", header=TRUE)
screenshots$timestamp <- as.POSIXct(screenshots$date, format="%m_%d_%H_%M_%S")
