if (selectionType!=0) {
	exit("Error: Needs a rectangular selection!");
}
//Get the bounds of the current selection
getSelectionBounds(x, y, w, h);
//Sets up two arrays to contain green (v1) and blue (v2) pixel values
v1=newArray(w*h);
v2=newArray(w*h);
//Loop through x and y coordinates to record values from the green channel
Stack.setChannel(2);
//For values of a between 0 and the width of the selection
for (a=0; a<w; a++) {
	//And values of b between 0 and the height of the selection
	for (b=0; b<h; b++) {
		//Record the value of the pixel in the corresponding array entry
		//The pixel value at (x+a, y+b) is recorded as array entry [a+b*w]
		v1[a+b*w]=getPixel(x+a, y+b);
	}
}
//Loop through x and y coordinates to record values from the blue channel
Stack.setChannel(3);
for (a=0; a<w; a++) {
	for (b=0; b<h; b++) {
		v2[a+b*w]=getPixel(x+a, y+b);
	}
}
//Do a linear regression analysis
//A positive linear correlation indicates co-localisation
//Carries out the actual fit
Fit.doFit("Straight Line", v1, v2);
//Plots the fit as a graph
Fit.plot();
//Prints the return values
print("R squared: "+Fit.rSquared()+" Gradient: "+Fit.p(1));