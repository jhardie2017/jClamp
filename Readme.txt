

JH_pC_Analysis_Gui.m and .fig were code written by Jason Hardie (jayhardie.jh@gmail.com) for use with pClamp data 
with abf extension. 

For abfload: 
Original version by Harald Hentschke (harald.hentschke@uni-tuebingen.de,https://github.com/hhentschke)
extended to abf version 2.0 by Forrest Collman (fcollman@Princeton.edu)

Date of this version: Sept 19, 2023


INSTALLATION INSTRUCTIONS:

	Copy abfload.m, JH_pC_Analysis_GUI.m, JH_pC_Analysis_GUI.fig, pC_Data.m to your MATLAB folder 
	(on my Windows 10 machine located in C:\Users\your_user_name\Documents\MATLAB)

	Open MATLAB. type "JH_pC_Analysis_GUI.m" in your command window. A user interface should open. 
	If not, check that you typed the name correctly, and that the files are in the same folder as your
	current MATLAB folder (in the address bar at the top) 


Here, I explain the  IF function. If there are other functions/features that you would like further help with, please
either message my  GitHub or email me at jayhardie.jh@gmail.com. 


To analyze IF (currrent-frequency) curve: 

1) Load the file (Assumed to be 1 sweep/current injection, incrementing current injection by sweep) 
using upper right hand corner button "Load File"

2) Enter the start time and end time of the trace you want to evaluate in the text boxes found under the "IF" button
in the mid-bottom left hand side of the interface, or using "Csr set" buttons.

3) Make sure the "threshold" is set correctly for your sweeps (here, threshold is the point where once an AP becomes
 more depolarized than the threshold, it is counted as an action potential)  

Your analysis will be automatically saved to the MATLAB workspace. For each analysis output, each row is from a sweep. 
APnums is the total number of action potentials detected between the cursors. freqs are the average frequencies during
the sweep, calculated from interspike intervals. If the neuron is firing  100% regularly,  freq = APnum/time(in sec).
If a neuron fires at the beginning of the sweep, then stops firing, the freq values will be  higher than APnum/time, 
because only the interspike interval times between spikes are taken into account. 

Peak, Height (from thresh to peak of AP), Width, Thresh, AHP are all calculated from the APs. Burst AHP and ADP are calculated
from the time after the end time to the end of the sweep.  


The IF function is the code in JH_pC_Analysis_Gui.m found under the line: 
"function pushbuttonIFcurve_Callback(hObject, eventdata, ~)" 

(Ctrl-F in the JH_pC_Analysis_Gui.m file will find it). If you want to modify the function, you would change it here. 
If you  find you are missing or overcounting spikes, you can either change the threshold (for AP detection) in the GUI, or you  may want to
change the coded refractory period (after the code detects a spike, it will ignore the trace for "refract" ms before detecting
the next spike. The default is refract=3;, however, change that number if spikes occur faster than that. 

If there are other file  types you would like to load, changes would be made in the 
function buttonloadfile_Callback(). This calls the load_file() function. So far, I have only coded for loading .abf files. 

To explore any of the code, type "GUIDE JH_pC_Analysis_Gui.m", and click on the button you are curious about. The 
"Inspector" will  pop  up, then click on the middle icon in the "Callback" line. That will automatically take you
to the related function.
