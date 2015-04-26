library(reshape2)

# #### IMPORT 3D PRINTER DATA ####
# TODO

#### IMPORT LASER CUTTER DATA ####
laser <- read.csv("laser.csv", header=TRUE)
colnames(laser) <- c("row_name", "timestamp", "current", "gas1_MQ9", "gas2_MQ2", "gas3_MQ9", "gas4_MQ2", "hot_wire_out", "hot_wire_rv", "hot_wire_tmp", "humidity", "lid_contact", "light", "temperature", "contact", "hour")
laser$timestamp <- as.POSIXct(laser$timestamp, format="%Y-%m-%d %H:%M:%S")
