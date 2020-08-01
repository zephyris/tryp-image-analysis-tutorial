//Bring up a window for the user to select a directory
path=getDirectory("");
//Save the raw data as a tiff
name=getTitle();
saveAs("TIFF", path+name+".tif");
//Set the display to all three channels in composite mode and save as a png
Stack.setDisplayMode("composite");
Stack.setActiveChannels("111");
saveAs("PNG", path+name+"_overlay.png");
//Set the display to the green channel only in greyscale mode and save as a png
Stack.setDisplayMode("grayscale");
Stack.setActiveChannels("010");
saveAs("PNG", path+name+"_gfp.png");
//Rename the image back to its starting name (it gets modified when saved)
rename(name);
