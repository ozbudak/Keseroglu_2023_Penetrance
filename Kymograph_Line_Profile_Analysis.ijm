input="C:/.../Analysis/";//Enter analysis folder path

Table.create("Line Profile");
z = getFileList(input+"1-MaxYFPs/");
ll=z.length;

for (i = 0; i < ll; i++) {

if(isOpen("Results")){close("Results");}
if(isOpen("ROI Manager")){close("ROI Manager");}

open(input+"1-MaxYFPs/"+z[i]);
title=getTitle;
extract=".tif";
file=substring(title,0,indexOf(title,extract));
Drug=substring(title,indexOf(title,"MAX_")+4,indexOf(title,"_YFP"));

open(input+"3-Kymographs/Kymograph of "+title);
getDimensions(width, height, channels, slices, frames);

selectWindow(title);
run("Line Width...", "line=15");
if (i<9) {no="0"+i+1;}else{no=i+1;}
open(input+"2-ROIs/RoiSet_"+file+".zip");	
roiManager("Select", 0);
roiManager("Select", roiManager("count")-1);
Roi.getPosition(channel, slice, frame);

SegFrame=newArray(0, 6, 12, 18, 24, 31, 37, 42, 48, 54, 60, 66, 72, 79, 86, 93, 100, 107);

run("LOI Interpolator", "average_over_line_width add_to_roi_manager");
run("Line Width...", "line=4");
getPixelSize(unit, p, h);

roiManager("select", SegFrame);
roiManager("measure");

selectWindow("Kymograph of "+title);

position="Df_S-3";
PSMRatio=newArray(0.699737662337662, 0.688433485288023, 0.671738586723769, 0.657081153067565, 0.634085533655634, 0.607263241106719, 0.574004487179487, 0.543550697674419, 0.50653012987013, 0.511511553438198, 0.503219396333792, 0.511256571867794, 0.535075322620643, 0.540790266982974, 0.559228475711893, 0.56698606271777, 0.658914124293785, 0.657547950819672);
makeLine(getResult("Length", 0)*PSMRatio[0]/p,getResult("Slice", 0)-1,getResult("Length", 1)*PSMRatio[1]/p,getResult("Slice", 1)-1,getResult("Length", 2)*PSMRatio[2]/p,getResult("Slice", 2)-1,getResult("Length", 3)*PSMRatio[3]/p,getResult("Slice", 3)-1,getResult("Length", 4)*PSMRatio[4]/p,getResult("Slice", 4)-1,getResult("Length", 5)*PSMRatio[5]/p,getResult("Slice", 5)-1,getResult("Length", 6)*PSMRatio[6]/p,getResult("Slice", 6)-1,getResult("Length", 7)*PSMRatio[7]/p,getResult("Slice", 7)-1,getResult("Length", 8)*PSMRatio[8]/p,getResult("Slice", 8)-1,getResult("Length", 9)*PSMRatio[9]/p,getResult("Slice", 9)-1,getResult("Length", 10)*PSMRatio[10]/p,getResult("Slice", 10)-1,getResult("Length", 11)*PSMRatio[11]/p,getResult("Slice", 11)-1,getResult("Length", 12)*PSMRatio[12]/p,getResult("Slice", 12)-1,getResult("Length", 13)*PSMRatio[13]/p,getResult("Slice", 13)-1,getResult("Length", 14)*PSMRatio[14]/p,getResult("Slice", 14)-1,getResult("Length", 15)*PSMRatio[15]/p,getResult("Slice", 15)-1,getResult("Length", 16)*PSMRatio[16]/p,getResult("Slice", 16)-1,getResult("Length", 17)*PSMRatio[17]/p,getResult("Slice", 17)-1);

File.makeDirectory(input+position);
newfolder=input+position+"/";
File.makeDirectory(newfolder+"Figures");
File.makeDirectory(newfolder+"Kymographs");

profile = getProfile();
getSelectionCoordinates(x, y);
selectWindow("Line Profile");
Table.setColumn("T_"+Drug, y);
Table.setColumn("V_"+Drug, profile);
close(title);
selectWindow("Kymograph of "+title);
saveAs("Tiff", newfolder+"Kymographs/"+position+"_Exp"+no+"_Kymograph of "+title+".tif"); 
close(position+"_Exp"+no+"_Kymograph of "+title+".tif");
}
close("ROI Manager");
close("Results");

selectWindow("Line Profile");
Table.save(newfolder+position+"_Exp"+".csv");
selectWindow("Line Profile");
close("Line Profile");