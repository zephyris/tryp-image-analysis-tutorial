//Variables setting the minimum and maximum area that looks like a single cell
minimumArea=2500;
maximumArea=8000;
//Use a built-in tool to make a point selection of all the thresholded particles
Stack.setChannel(1);
run("Select None");
run("Find Maxima...", "noise=10 output=[Point Selection]");
//Record the list of coordinates of the particles as two arrays, x and y
getSelectionCoordinates(x, y);
//Loop through the list of coordinates to analyse the particles
for (i=0; i<lengthOf(x); i++) {
//Select the thresholded phase contrast image
Stack.setChannel(1);
//Use the wand selector to select the particle
doWand(x[i], y[i]);
//Get the particle area (in pixels)
getRawStatistics(area);
if (area>minimumArea && area<maximumArea) {
	//Only analyse particles large enough to be a cell
	//Check the bounds of the selection
	getSelectionBounds(sx, sy, sw, sh);
	if (sx>0 && sy>0 && sx+sw<getWidth()-1 && sy+sh<getHeight()-1) {
		//Only analyse if the particle is not touching the image edge
		//Get the image intensity from the DNA stain channel
		Stack.setChannel(3);
		getRawStatistics(area, mean);
		//Output the result
		print(x[i], y[i], area, mean*area);
	} else {
		//'Delete' particles which should not be analysed
		setColor(0);
		fill();
	}
} else {
	//'Delete' particles which should not be analysed
	setColor(0);
	fill();
	}
}