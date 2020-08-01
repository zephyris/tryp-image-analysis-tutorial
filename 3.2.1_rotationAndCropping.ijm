//Two variables to define the output image size in pixels
width=323;
height=162;

//Check if the current selection type is 5 (a line selection)
if (selectionType()!=5) {
//Exit and display an error if the selection is missing or is not a line
	exit("Error: No line selection found!");
}
//Get the coordinates of the user-specified line
//This sets x and y to arrays which describe the x and y coordinates of the selection
getSelectionCoordinates(x, y);
//Calculate the orientation and center of the line
angle=-180*atan2(y[1]-y[0], x[1]-x[0])/PI;
centerX=(x[1]+x[0])/2;
centerY=(y[1]+y[0])/2;
print("Center: "+centerX+"px, "+centerY+"px Orientation: "+angle+" degrees");

//Start the cropping process
//First, calculate a temporary image width
//This will allow subsequent rotation of the image without clipping
tempWidth=pow(width*width/4+height*height/4, 0.5);
//Make a rectangle of twice the temporary width around the cell
makeRectangle(centerX-tempWidth, centerY-tempWidth, tempWidth*2, tempWidth*2);
//Duplicate this region of the image to a new image
run("Duplicate...", "duplicate");
//Rotate by the angle
run("Rotate... ", "angle="+angle+" grid=1 interpolation=Bicubic stack");
//Crop to the outut image size
makeRectangle(tempWidth-width/2, tempWidth-height/2, width, height);
run("Crop");