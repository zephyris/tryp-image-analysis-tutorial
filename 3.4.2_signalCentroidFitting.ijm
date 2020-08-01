//Distance in pixels to use for Gaussian fitting
r=6;
//Call the custom refinePoints function
//This refines every point in a user-specified selection
refinePoints(r);

function refinePoints(r) {
	//Get the coordinates of the point selection
	if (selectionType()!=10) {
		exit("Error: Point selection needed!");
	}
	getSelectionCoordinates(x, y);
	//Setup output arrays for the corrected x and y coordinates
	ox=newArray(); oy=newArray();
	for (i=0; i<lengthOf(x); i++) {
		//For every point, make a point selection
		//Round the coordinates to the nearest pixel
		makePoint(round(x[i]), round(y[i]));
		//Call the custom refinePoint function to do the Gaussian fitting
		refinePoint(r);
		//Check if a selection exists
		//(if the refinePoint function can't fit the Gaussian)
		if (selectionType!=-1) {
			//Record the refined location for output
			getSelectionCoordinates(cx, cy);
			ox=Array.concat(ox, cx); oy=Array.concat(oy, cy);
		}
	}
	//Make a point selection of the refined points
	makeSelection("points", ox, oy);
}

function refinePoint(r) {
	//Record the ID of the original image
	src=getImageID();
	//Get the coordinates of the point to refine
	getSelectionCoordinates(x, y);
	x=x[0]; y=y[0];
	if (x>=r && y>=r && x<getWidth()-r && y<getHeight()-r) {
		//Only continue if the point is not too close to the image edge
		xo=x; yo=y;
		//Duplicate a rectangle around the point to refine
		makeRectangle(x-r, y-r, r*2, r*2);
		run("Duplicate...", " ");
		tmp=getImageID();
		//Do the Gaussian fitting
		//This part of the code needs to be run in the X and Y direction
		//By using a for loop the code can avoid unnecessary duplication
		for (o=0; o<2; o++) {
		//Select the image and get the signal intensity profile
		makeRectangle(0, 0, r*2, r*2);
		vy=getProfile();
		//Setup an array of horizontal pixel positions
		vx=newArray(lengthOf(vy));
		for (i=0; i<lengthOf(vx); i++) {
		//The offset of 0.5 is due to the handling of pixel data
		//The distances are from the top left corner of the pixel
		vx[i]=i-r+0.5;
		}
		//Do the gaussian fit
		Fit.doFit("Gaussian", vx, vy);
		if (Fit.rSquared()>0.9) {
			//If a good fit is achieved
			if (Fit.p(2)>-r/2 && Fit.p(2)<r/2) {
				//And the centre of the Gaussian reasonable
				//Correct either the X or Y coordinate
				if (o==0) {
					x+=Fit.p(2);
				} else if (o==1) {
					y+=Fit.p(2);	
				}
			} else {
				//Failure to fit returns an invalid number
				if (o==0) {
					x=0/0;
				} else if (o==1) {
					y=0/0;
				}
			}
		} else {
			//Failure to fit returns an invalid number
			if (o==0) {
				x=0/0;
			} else if (o==1) {
				y=0/0;
			}
		}
		if (o==0) {
			//After the first (X) loop rotate the image for Y
			run("Rotate 90 Degrees Left");
		} else if (o==1) {
			//After the second loop close the temporary image
			selectImage(tmp);
			close();
			}
		}
	} else {
		//Return an invalid number if too close to the image edge
		x=0/0; y=0/0;
	}
	//Make a selection of the corrected point location in the source image
	selectImage(src);
	if (!isNaN(x) && !isNaN(y)) {
		makePoint(x, y);
	} else {
		run("Select None");
	}
	setBatchMode(false);
}