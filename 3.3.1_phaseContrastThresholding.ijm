//Select the phase contrast image
Stack.setChannel(1);
run("Select None");
//Switch to grayscale display mode, as thresholding only works in this mode
Stack.setDisplayMode("grayscale");
//Filter the phase image to highlight particles the size of trypanosomes
run("Unsharp Mask...", "radius=10 mask=0.60 slice");
run("Unsharp Mask...", "radius=20 mask=0.60 slice");
run("Subtract Background...", "rolling=25 light slice");
//Threshold the image
setOption("BlackBackground", true);
setAutoThreshold("Default");
//Next we manually convert this image to a binary image (either black 0 or white 255)
//This is a little more manual than the built-in ImageJ tools to handle the 16-bit image
getThreshold(min, max);
changeValues(0, max, 0);
changeValues(max, pow(2, 16)-1, 255);
run("Macro...", "code=v=255-v slice");
//Filter and re-threshold the binary image
//This helps separate closely-spaced cells
run("Gaussian Blur...", "sigma=3 slice");
changeValues(0, 192, 0);
changeValues(192, 255, 255);