//This script can be installed using Plugins>Macros>Install...
//When installed it will appear under Plugins>Macros>Save and close all images
macro "Save and close all images" {
	//Display a directory select dialog and record the path in the variable path
	path=getDirectory("");
	//Call the custom function saveImagesToPath
	saveImagesToPath(path);
}

//A custom function which could also be used elsewhere in the script
function saveImagesToPath(path) {
	//A while loop which continues until no images are open
	while (nImages()>0) {
		//Select the first image, save it and close it
		selectImage(1);
		saveAs("TIFF", path+getTitle());
		close();
	}
}