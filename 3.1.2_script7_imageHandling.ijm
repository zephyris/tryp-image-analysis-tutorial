//Create a new hyperstack
newImage("HyperStack", "16-bit composite-mode label", 400, 300, 3, 1, 5);
//Set the display mode to greyscale
Stack.setDisplayMode("grayscale");
//Set the displayed image to channel 2 of the 5th timepoint
Stack.setChannel(2);
Stack.setFrame(5);