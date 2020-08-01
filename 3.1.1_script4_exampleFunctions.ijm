//This immediately makes a new image using these parameters
newImage("Image1", "16-bit black", 100, 150, 1);
//This runs the ImageJ pow() exponent function
//It returns a number, and the variable a is set to the result
a=pow(2, 16);
//This runs the ImageJ getSelectionCoordinates() function
//The variables x and y are both set to equal two different parts of the result
getSelectionCoordinates(x, y);