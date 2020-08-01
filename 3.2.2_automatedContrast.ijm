//The phase contrast and DNA stain images are set to have 0.1% clipped pixels
//This gives good contrast for easy viewing
//The Green fluorescence image is set to have 0% clipped pixels
//This ensures no image data is lost in saturated bright or clipped dark pixels
//Phase contrast
Stack.setChannel(1);
run("Grays");
run("Enhance Contrast", "saturated=0.1");
//Green fluorescence
Stack.setChannel(2);
run("Green");
run("Enhance Contrast", "saturated=0");
//DNA stain
Stack.setChannel(3);
run("Magenta");
run("Enhance Contrast", "saturated=0.1");