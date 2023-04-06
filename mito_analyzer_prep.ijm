input = getDirectory("Input directory");
output_mito = getDirectory("mito directory");
output_other = getDirectory("other directory");

processFolder(input); 

function processFolder(dir) {
	list = getFileList(dir);
	for (i=0; i<list.length; i++) {
    	        if(endsWith(list[i], ".tif")) { //add the file ending for your images
    		    processFile(list[i]);
		} else if(endsWith(list[i], "/") && !matches(output, ".*" + substring(list[i], 0, lengthOf(list[i])-1) + ".*")) {
   		    //if the file encountered is a subfolder, go inside and run the whole process in the subfolder
    		    processFolder(""+list[i]);
		} else {
    		    //if the file encountered is not an image nor a folder just print the name in the log window
       		    print(list[i] + " is an invalid file.");
		}
    }
}


function processFile(file) {
	open(input + file);
	run("Split Channels");
	selectWindow("C1-" + file);
	run("8-bit");
	Stack.setXUnit("micron");
    saveAs("tif", output_other + getTitle);
    selectWindow("C2-" + file);
    run("8-bit");
    Stack.setXUnit("micron");
    saveAs("tif", output_mito + getTitle);
    run("Close All");
}