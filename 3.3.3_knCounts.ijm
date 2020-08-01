//The area threshold to count as a kinetoplast or nucleus
knAreaCutoff=100;

//Set the DNA stain channel
Stack.setChannel(3);
run("Select None");
//Do a small blur then thresholding, similar to the phase contrast image
run("Gaussian Blur...", "sigma=1 slice");
setAutoThreshold("Otsu dark");
getThreshold(min, max);
changeValues(0, min, 0);
changeValues(min, pow(2, 16)-1, 255);

//Repeat the cell detection as before
//The cells have already been filtered to be within the necessary size range
Stack.setChannel(1);
run("Find Maxima...", "noise=10 output=[Point Selection]");
getSelectionCoordinates(x, y);
for (i=0; i<lengthOf(x); i++) {
	Stack.setChannel(1);
	doWand(x[i], y[i]);
	//Do the kinetoplast and nucleus count
	countKN(knAreaCutoff);
}

function countKN(knAreaCutoff) {
	//Setup variables to record the count of Ks and Ns
	kCount=0;
	nCount=0;
	Stack.setChannel(3);
	//Analyse the particles using the same strategy as for the cells
	run("Find Maxima...", "noise=10 output=[Point Selection]");
	getSelectionCoordinates(x2, y2);
	for (i=0; i<lengthOf(x2); i++) {
		//Select the current DNA particle
		doWand(x2[i], y2[i]);
		getRawStatistics(area);
			//If the area is larger than the cutoff count as N, otherwise K
		if (area>knAreaCutoff) {
			nCount++;
		} else {
					kCount++;
		}
	}
	//Print the resulting K and N count
	print(kCount+"K"+nCount+"N");
}