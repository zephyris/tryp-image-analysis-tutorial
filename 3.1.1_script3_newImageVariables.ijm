//Starting variables
//The base and channel names are strings
baseName="NewImage";
channelName="Red";
//The base dimension is an integer
baseDimension=128;
//Variables derived from the starting variables
//Concatenating strings (image name)
finalName=baseName+"_"+channelName;
//Mathematics using numbers (image dimensions)
width=baseDimension;
height=baseDimension*2;
newImage(finalName, "16-bit black", width, height, 1);