#### IMPORT 3D PRINTER DATA ####
printer <- read.csv("printer.csv")
printer$timestamp <- as.POSIXct(printer$timestamp, format="%Y-%m-%d %H:%M:%S")
colnames(printer) <- c("row_name", "timestamp", "acc_board_x", "acc_board_y", "acc_board_z", "acc_top_x", "acc_top_Y", "acc_top_Z", "current", "dist_to_board", "light", "contact", "hour")

#### IMPORT LASER CUTTER DATA ####
laser <- read.csv("laser.csv", header=TRUE)
colnames(laser) <- c("row_name", "timestamp", "current", "gas1_MQ9", "gas2_MQ2", "gas3_MQ9", "gas4_MQ2", "hot_wire_out", "hot_wire_rv", "hot_wire_tmp", "humidity", "lid_contact", "light", "temperature", "contact", "hour")
laser$timestamp <- as.POSIXct(laser$timestamp, format="%Y-%m-%d %H:%M:%S")


# #### IMPORT ROOM DATA ####
room <- read.csv("room.csv", header=TRUE)
room$timestamp <- as.POSIXct(room$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT CNC DATA ####
cnc <- read.csv("cnc.csv", header=TRUE)
cnc$timestamp <- as.POSIXct(cnc$timestamp, format="%Y-%m-%d %H:%M:%S")

#### IMPORT SURVEY DATA ####
survey <- read.csv("survey.csv", header=TRUE)
survey$timestmp <- as.POSIXct(survey$timestamp, format="%Y-%m-%d %H:%M:%S")