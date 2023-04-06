input = getDirectory("Input directory");
output = getDirectory("Output directory");

processFolder(input); 

function processFolder(dir) {
	list = getFileList(dir);
	for (i=0; i<list.length; i++) {
    	        if(endsWith(list[i], ".tif")) { //add the file ending for your images
    		    processFile(dir, output, list[i]);
		} else if(endsWith(list[i], "/") && !matches(output, ".*" + substring(list[i], 0, lengthOf(list[i])-1) + ".*")) {
   		    //if the file encountered is a subfolder, go inside and run the whole process in the subfolder
    		    processFolder(""+dir+list[i]);
		} else {
    		    //if the file encountered is not an image nor a folder just print the name in the log window
       		    print(list[i] + " is an invalid file.");
		}
    }
}


function processFile(inputFolder, output, file) {
	open(inputFolder + file);
	run("Split Channels");
	close("C2*");
    saveAs("tiff", output + getTitle);
    run("Close All");
}