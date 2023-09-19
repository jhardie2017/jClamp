function varargout = JH_pC_Analysis_GUI(varargin)
% JH_PC_ANALYSIS_GUI MATLAB code for JH_pC_Analysis_GUI.fig
%      JH_PC_ANALYSIS_GUI, by itself, creates a new JH_PC_ANALYSIS_GUI or raises the existing
%      singleton*.
%
%      H = JH_PC_ANALYSIS_GUI returns the handle to a new JH_PC_ANALYSIS_GUI or the handle to
%      the existing singleton*.
%
%      JH_PC_ANALYSIS_GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in JH_PC_ANALYSIS_GUI.M with the given input arguments.
%
%      JH_PC_ANALYSIS_GUI('Property','Value',...) creates a new JH_PC_ANALYSIS_GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before JH_pC_Analysis_GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to JH_pC_Analysis_GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help JH_pC_Analysis_GUI

% Last Modified by GUIDE v2.5 16-Aug-2021 12:47:27


% Include in a callback to get and change figure data
% [hOBJECT, hFIGURE] = gcbo;
% fhandles = guidata(hFIGURE); %retrieve gui data
% 
%     code here
% 
% guidata(hFIGURE, fhandles);  %update gui data

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @JH_pC_Analysis_GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @JH_pC_Analysis_GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before JH_pC_Analysis_GUI is made visible.
function JH_pC_Analysis_GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to JH_pC_Analysis_GUI (see VARARGIN)

% Choose default command line output for JH_pC_Analysis_GUI
handles.output = hObject; %changed 12/16/2022 Change Back to "handles.output = hObject" if fucked

set(handles.radioautoflag,'Value',1);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes JH_pC_Analysis_GUI wait for user response (see UIRESUME)
% uiwait(handles.pC_GUI);


% --- Outputs from this function are returned to the command line.
function varargout = JH_pC_Analysis_GUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



% --- Executes on button press in buttonloadfile.
function buttonloadfile_Callback(hObject, eventdata, handles)
% hObject    handle to buttonloadfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% 


[hOBJECT, hFIGURE] = gcbo;

fhandles = guidata(hFIGURE);  %retrieve gui data



command = sprintf('%s\\*.abf',fhandles.pathname);

[filename,pathname] = uigetfile(command,'Pick Your Poison');
                        
set(fhandles.filepathedit,'String',pathname);
 

 

fhandles.filename=filename;
fhandles.pathname=pathname;
fhandles.sweepnum=1;
fhandles.hold=0;
fhandles.autoscaleflag=1;

 
 guidata(hFIGURE, fhandles); %update handles structure


 
 load_file(hFIGURE);
 fhandles = guidata(hFIGURE);  %retrieve gui data
 set(fhandles.textfilename,'String',filename);
 set(fhandles.textsweepnum,'String',num2str(fhandles.sweepnum))
 
 
 


 
 
 
 
 
 
 

 



function textfilename_Callback(hObject, eventdata, fhandles)
% hObject    handle to textfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textfilename as text
%        str2double(get(hObject,'String')) returns contents of textfilename as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data


filename=get(fhandles.textfilename,'String');

fhandles.filename=filename;

guidata(hFIGURE, fhandles);  %update handles structure

load_file(hFIGURE);



 



% --- Executes during object creation, after setting all properties.
function textfilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textfilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





%structure of user made functions for analysis: hFIGURE is handle to 
%figure. Handles is a structure 


    function flag=load_file(hFIGURE) 
        
        
        fhandles = guidata(hFIGURE);

        
            fhandles.autoscaleflag=get(fhandles.radioautoflag,'value');
            fhandles.APthresh=str2num(get(fhandles.APthreshedit,'String'));
            
            fhandles.IFend=str2num(get(fhandles.editIFend,'String'));
            fhandles.IFstart=str2num(get(fhandles.editIFstart,'String'));
            fhandles.sagstart=str2num(get(fhandles.editsagstart,'String'));
            fhandles.sagend=str2num(get(fhandles.editsagend,'String'));
       
            fhandles.MultiPeakstart=str2num(get(fhandles.editMultiPeakstart,'String'));
            
            fhandles.MultiPeakfreq=str2num(get(fhandles.editMultiPeakfreq,'String'));

            localname=strcat(fhandles.pathname,fhandles.filename);
             
             [d,si,h]=abfload(localname);
             
              sz=size(d);
             
             
             
             
       
                fhandles.xunits='ms';
                si=si/1000;
         
             
             
             fhandles.filedata=d;
             fhandles.si=si;
             fhandles.finfo=h;
%              
             
             
             dimnum=ndims(d);
             
            
             totalsweeps=sz(end);
             fhandles.totalsweeps=totalsweeps;
             
      
             
             if(totalsweeps>=fhandles.sweepnum)
                    
                 if(dimnum==3) %For episodic: data comes as time(row) x value(col) x sweep (level) 3d matrix
                    fhandles.y=d(:,1,fhandles.sweepnum);
                 elseif (dimnum==2) %For gap free
                    fhandles.y=d(:,fhandles.sweepnum);
                 end
                 
           
                 flag=1;
                 
                
             else
                 flag=0;
                 fhandles.sweepnum=1;
                 fhandles.y=d(:,1,fhandles.sweepnum);
                   
             end
             
            
             
            
             sz=size(fhandles.filedata);
             fhandles.datasweeps=[];
             


             if ndims(fhandles.filedata)==3
                 
                 for i = 1:sz(3)
                     fhandles.datasweeps(:,i)=fhandles.filedata(:,1,i);
                 end
                 
             else
                 for i = 1:sz(2)
                     fhandles.datasweeps(:,i)=fhandles.filedata(:,i);
                 end
             end
             
             
             
             fhandles.rectime=sec2hms(h.recTime(1));
             set(fhandles.textrectime,'string',fhandles.rectime);
             
             
             set(fhandles.textsweepnum,'String',num2str(fhandles.sweepnum));
             
             fhandles.x=(0:si:(length(d(:,1))-1)*si)';
             
             
             
             
             xl=xlim;
             yl=ylim;
             
             
                 
             if fhandles.hold==1
                 hold on;
             else
                 hold off;
             end
             
             
             plotallflag=get(fhandles.radioplotallflag,'value');
             
             
             if plotallflag==0
                plot(fhandles.x,fhandles.y);
             else
                 plot(fhandles.x,fhandles.datasweeps)
             end
           
             
             if fhandles.autoscaleflag==0
                 xlim(xl);
                 ylim(yl);
             end
             
             if strcmp(fhandles.finfo.recChUnits,'mV');
                 ylabel('Membrane Voltage (mV)','FontSize',14);
             else strcmp(fhandles.finfo.recChUnits,'pA');
                 ylabel('Current (pA)','FontSize',14);
             end
             
             if fhandles.xunits=='s'
                xlabel('Time (s)','FontSize',14);
             elseif fhandles.xunits=='ms'
                xlabel('Time (ms)','FontSize',14);
             end
                 
             
             
             
guidata(hFIGURE, fhandles); %update handles structure
    
   
    
    
function hms=sec2hms(t)
    
        hours = floor(t / 3600);
        t = t - hours * 3600;
        mins = floor(t / 60);
        secs = round(t - mins * 60);
        
        if hours>12
            hours=hours-12;
            post=' pm';
        else
            post=' am';
        end
        
        hms = sprintf('%02d:%02d:%02d\n', hours, mins, secs);
        
        hms=strcat(hms,post);

    
function filestring=lastfilename(thisfilestring,pathname)  %finds file of number thisnumber-1 and returns string of that name
    
       k=strfind(thisfilestring,'.abf');

numhere=str2num(thisfilestring(k-3:k-1));

namehere=thisfilestring;

if numhere>1 && numhere<11 %after subtracting 1, file num is 1 digit
    newname=namehere(1:k-4);
    newname(k-3:k-2)='0';
    newname(k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
elseif numhere>10 && numhere<100 %after subtracting 1, file num is 2 digits
    newname=namehere(1:k-4);
    newname(k-3)='0';
    newname(k-2:k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
else %after subtracting 1, file num is 3 digits
    newname=namehere(1:k-4);
    newname(k-3:k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
end


namehere=strcat(pathname,newname);

if exist(namehere,'file')==2
   filestring=newname;
   
else
    filestring=thisfilestring;%returns original name as new name, because num-1 file does not exist
    
end





function textsweepnum_Callback(hObject, eventdata, handles)
% hObject    handle to textsweepnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textsweepnum as text
%        str2double(get(hObject,'String')) returns contents of textsweepnum as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.sweepnum=str2num(get(fhandles.textsweepnum,'String'));


guidata(hFIGURE, fhandles);  %update handles structure

flag=load_file(hFIGURE);






% --- Executes during object creation, after setting all properties.
function textsweepnum_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textsweepnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end





% --- If Enable == 'on', executes on mouse press in 5 pixel border.
% --- Otherwise, executes on mouse press in 5 pixel border or over textsweepnum.
function textsweepnum_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to textsweepnum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in buttonlastsweep.
function buttonlastsweep_Callback(hObject, eventdata, handles)
% hObject    handle to buttonlastsweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

sweepnumhere=str2num(get(fhandles.textsweepnum,'String'));

if(sweepnumhere>1)
    fhandles.sweepnum=sweepnumhere-1;
    set(fhandles.textsweepnum,'String', fhandles.sweepnum);
    guidata(hFIGURE, fhandles);
    load_file(hFIGURE);
else
    fhandles.filename=lastfilename(fhandles.filename,fhandles.pathname);
    set(fhandles.textfilename,'String', fhandles.filename);
    guidata(hFIGURE, fhandles); %update gui data
    load_file(hFIGURE);
    
    [hOBJECT, hFIGURE] = gcbo;
    fhandles = guidata(hFIGURE); %retrieve new gui data
    
    fhandles.sweepnum=fhandles.totalsweeps;
    set(fhandles.textsweepnum,'String', fhandles.sweepnum);
    guidata(hFIGURE, fhandles);
    load_file(hFIGURE);
    
    
end

    




%update handles structure


% --- Executes on button press in buttonnextsweep.
function buttonnextsweep_Callback(hObject, eventdata, handles)
% hObject    handle to buttonnextsweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

sweepnumhere=str2num(get(fhandles.textsweepnum,'String'));

totalsweeps=fhandles.totalsweeps;

if(sweepnumhere<totalsweeps)
    fhandles.sweepnum=sweepnumhere+1;
    set(fhandles.textsweepnum,'String', fhandles.sweepnum)
    guidata(hFIGURE, fhandles);  %update gui data
    load_file(hFIGURE);
else sweepnumhere==totalsweeps;
    pushnextfile_Callback(fhandles.pushnextfile,eventdata,handles);
end


% --- Executes on button press in radiohold.
function radiohold_Callback(hObject, eventdata, handles)
% hObject    handle to radiohold (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiohold

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

holdflag=get(hObject,'Value');

fhandles.hold=holdflag;


 guidata(hFIGURE, fhandles);  %update gui data


% --- Executes on button press in pushnextfile.
function pushnextfile_Callback(hObject, eventdata, handles)
% hObject    handle to pushnextfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

namehere=fhandles.filename;

k=strfind(namehere,'.abf');

numhere=str2num(namehere(k-3:k-1));

if numhere<9
    newname=namehere(1:k-4);
    newname(k-3:k-2)='0';
    newname(k-1)=num2str(numhere+1);
    newname(k:k+3)='.abf';
elseif numhere>8 && numhere<99 
    newname=namehere(1:k-4);
    newname(k-3)='0';
    newname(k-2:k-1)=num2str(numhere+1);
    newname(k:k+3)='.abf';
else
    newname=namehere(1:k-4);
    newname(k-3:k-1)=num2str(numhere+1);
    newname(k:k+3)='.abf';
    
end


namehere=strcat(fhandles.pathname,newname);

if exist(namehere,'file')==2
    fhandles.filename=newname;
    fhandles.sweepnum=1;
    set(fhandles.textfilename,'String',newname)
    guidata(hFIGURE, fhandles);  %update gui data
    load_file(hFIGURE);
    
end









 


% --- Executes on button press in buttonlastfile.
function buttonlastfile_Callback(hObject, eventdata, handles)
% hObject    handle to buttonlastfile (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

namehere=fhandles.filename;

k=strfind(namehere,'.abf');

numhere=str2num(namehere(k-3:k-1));

if numhere>1 && numhere<11 %after subtracting 1, file num is 1 digit
    newname=namehere(1:k-4);
    newname(k-3:k-2)='0';
    newname(k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
elseif numhere>10 && numhere<100 %after subtracting 1, file num is 2 digits
    newname=namehere(1:k-4);
    newname(k-3)='0';
    newname(k-2:k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
else %after subtracting 1, file num is 3 digits
    newname=namehere(1:k-4);
    newname(k-3:k-1)=num2str(numhere-1);
    newname(k:k+3)='.abf';
end


namehere=strcat(fhandles.pathname,newname);

if exist(namehere,'file')==2
    fhandles.filename=newname;
%     fhandles.sweepnum=1;
    set(fhandles.textfilename,'String',newname)
    guidata(hFIGURE, fhandles);  %update gui data
    load_file(hFIGURE);
    
end


% --- Executes on button press in radioautoflag.
function radioautoflag_Callback(hObject, eventdata, handles)
% hObject    handle to radioautoflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioautoflag
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data


fhandles.autoscaleflag=get(hOBJECT,'value');


guidata(hFIGURE, fhandles);  %update gui data


% --- Executes on button press in buttonsavesweep.
function buttonsavesweep_Callback(hObject, eventdata, handles)
% hObject    handle to buttonsavesweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

clipflag=get(fhandles.radioclipflag,'value');


wsname=fhandles.textsavesweep.String;


eval('global xunits');
assignin('base','xunits',fhandles.xunits);
assignin('base','sint',fhandles.si);
si=fhandles.si;


if clipflag==0

temp=fhandles.y;
tempx=fhandles.x;


elseif clipflag==1

    
dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

    

starts=get(fhandles.editstartclip,'string');

startms=str2num(starts);

startms=csrx-startms;

start=round(startms/si);

ends=get(fhandles.editendclip,'string');

endms=str2num(ends);

endms=csrx + endms;
daend=round(endms/si);


temp=fhandles.y(start:daend,:);
tempx=(0:si:(length(temp)-1)*si)';    
end


assignin('base',strcat(wsname,'x'),tempx);
assignin('base',wsname,temp);









    



guidata(hFIGURE, fhandles);  %update gui data

function textsavesweep_Callback(hObject, eventdata, handles)
% hObject    handle to textsavesweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textsavesweep as text
%        str2double(get(hObject,'String')) returns contents of textsavesweep as a double


% --- Executes during object creation, after setting all properties.
function textsavesweep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textsavesweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function textrectime_Callback(hObject, eventdata, handles)
% hObject    handle to textrectime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textrectime as text
%        str2double(get(hObject,'String')) returns contents of textrectime as a double


% --- Executes during object creation, after setting all properties.
function textrectime_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textrectime (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in buttonbaseline.
function buttonbaseline_Callback(hObject, eventdata, handles)
% hObject    handle to buttonbaseline (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data



dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);


xdelta=get(fhandles.textblwidth,'String');
xdelta=str2num(xdelta);


    x1i=round((csrx-xdelta)/fhandles.si);
    x2i=round((csrx+xdelta)/fhandles.si);

avg=mean(fhandles.y(x1i:x2i));
fhandles.y=fhandles.y-avg;


      xl=xlim;
      yl=ylim;
             
             
                 
             if fhandles.hold==1
                 hold on;
             else
                 hold off;
             end
             
             plot(fhandles.x,fhandles.y);
          
             
             
             if fhandles.autoscaleflag==0
                 xlim(xl);
                 ylim auto
             end


         
             
for i=1:fhandles.totalsweeps
    avg=mean(fhandles.datasweeps(x1i:x2i,i));
    fhandles.datasweeps(:,i)=fhandles.datasweeps(:,i)-avg;
    
end
            

guidata(hFIGURE, fhandles);  %update gui data





% --- Executes on button press in radioclipflag.
function radioclipflag_Callback(hObject, eventdata, handles)
% hObject    handle to radioclipflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioclipflag



function editstartclip_Callback(hObject, eventdata, handles)
% hObject    handle to editstartclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editstartclip as text
%        str2double(get(hObject,'String')) returns contents of editstartclip as a double


% --- Executes during object creation, after setting all properties.
function editstartclip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editstartclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editendclip_Callback(hObject, eventdata, handles)
% hObject    handle to editendclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editendclip as text
%        str2double(get(hObject,'String')) returns contents of editendclip as a double


% --- Executes during object creation, after setting all properties.
function editendclip_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editendclip (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in radioappendflag.
function radioappendflag_Callback(hObject, eventdata, handles)
% hObject    handle to radioappendflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioappendflag


% --- Executes on button press in radioappendflag.
function radiobutton6_Callback(hObject, eventdata, handles)
% hObject    handle to radioappendflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioappendflag





     
     
   

% --- Executes on button press in buttonsaveall.
function buttonsaveall_Callback(hObject, eventdata, handles)
% hObject    handle to buttonsaveall (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data



 wsname=fhandles.textfilename.String;
 k=strfind(wsname,'.abf');

wsname=wsname(1:k-1);

wsname=strcat('f',wsname);


% assignin('base',wsname,fhandles.datasweeps);

% assignin('base','x',fhandles.x);

file(:,1)=fhandles.x;
file(:,2:size(fhandles.datasweeps,2)+1)=fhandles.datasweeps;

assignin('base','file',file);

fprintf('saved %s to "file" in workspace, %d rows, %d cols \n',wsname,size(file,1),size(file,2));

guidata(hFIGURE, fhandles);  %update gui data






% --- Executes on button press in buttonmakefig.
function buttonmakefig_Callback(hObject, eventdata, handles)
% hObject    handle to buttonmakefig (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% From CREATEFIGURE(X1, YMATRIX1)
%  X1:  vector of x data
%  YMATRIX1:  matrix of y data

%  Auto-generated by MATLAB on 09-Jul-2018 16:23:20

% Create figure





%hold on

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data


sz=size(fhandles.datasweeps);

if(sz(2)>10)
    integer=round(sz(2)/10);
    y=fhandles.datasweeps(:,1:integer:sz(2));
else
    y=fhandles.datasweeps;
end


x=fhandles.x;


    fig=figure; %creates handle to current figure
   
    
    
    
plot(fhandles.x,y);


fig.Position=[360 390 400 240];


ylabelstring=fhandles.finfo.recChUnits;

if strcmp(ylabelstring,'mV')
    ylabel('V_M_e_m (mV)','FontSize',12);
else
    ylabel('Current (pA)','FontSize',12);
end

 
if strcmp(fhandles.xunits,'ms')
     xlabel('Time (ms)','FontSize',12);
else
     xlabel('Time (S)','FontSize',12);
end

 


             

%  
%  
%  guidata(hFIGURE, fhandles);  %update gui data
%  
% % Use: fig = get(groot,'CurrentFigure') to query propeties of this figure. 

 
% Uncomment the following line to preserve the X-limits of the axes
% xlim(axes1,[6489.77843300233 6601.38267127874]);
% Uncomment the following line to preserve the Y-limits of the axes
% ylim(axes1,[-71.25 17.9166666666667]);



function textblwidth_Callback(hObject, eventdata, handles)
% hObject    handle to textblwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of textblwidth as text
%        str2double(get(hObject,'String')) returns contents of textblwidth as a double


% --- Executes during object creation, after setting all properties.
function textblwidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to textblwidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



% --- Executes on button press in radioplotallflag.
function radioplotallflag_Callback(hObject, eventdata, handles)
% hObject    handle to radioplotallflag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioplotallflag


% --- Executes on button press in buttonpeak.
function buttonpeak_Callback(hObject, eventdata, handles)
% hObject    handle to buttonpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data


avgwindow=3; %points to average before and after,with si of 100 uS, will be 1 ms


dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});




deltax=get(fhandles.editdeltax,'String');
deltax=str2num(deltax);


csrx=csrpos(1);

startp=floor(csrx/fhandles.si);
endp=floor((csrx+deltax)/fhandles.si);



bl=mean(fhandles.y(startp-(20/fhandles.si):startp));
% bl=0;

temptrace=fhandles.y(startp:endp);


[damax,damaxi]=max(fhandles.y(startp:endp));
[damin,damini]=min(fhandles.y(startp:endp));




if damax>abs(damin)
    damax=mean(fhandles.y(startp+damaxi-avgwindow:startp+damaxi+avgwindow));
    damax=damax-bl;
    peak=damax;
    t1=(damaxi+startp)*fhandles.si;
else
    damin=mean(fhandles.y(startp+damini-avgwindow:startp+damini+avgwindow));
    damin=damin-bl;
    peak=damin;
    t1=(damini+startp)*fhandles.si;
end

area = sum(fhandles.y(startp:endp)) - bl*(endp-startp+1);
area = area*fhandles.si/1000;

% calculate AP num (deflections above -30 mV)
idxl = temptrace>=-15;
    idxl(1) = 0;
    idx = find(idxl);
    yest = temptrace(idx-1)<-15; 
    
    ap_ind = find(yest);
    apnum = length(ap_ind);


fprintf("peak is : %.3f pA at time %.3f ms \n",peak,t1);
fprintf("area is : %.3f pA*S \n", area);
fprintf("AP num is : %.3f \n", apnum);


% fhandles.analysis_peak
% exist('fhandles.analysis_peak')
% exist('fhandles.analysis_peak') &&


if  fhandles.appendpeakflag==1
    
    peaks=fhandles.analysis_peak;
    peaks(size(peaks,1) + 1, 1)=t1;
    peaks(size(peaks,1), 2)=peak;
    peaks(size(peaks,1), 3)=area;
    peaks(size(peaks,1), 4)=apnum;
    
    
    fhandles.analysis_peak=peaks;
    
else
    
    peaks(1,1)=t1;
    peaks(1,2)=peak;
    peaks(1,3)=area;
    peaks(1, 4)=apnum;
    fhandles.analysis_peak=peaks;
    
end



assignin('base','peaks',peaks);

p1=damin;


%Finds next peak 5 secs after cursor, then calculates ratio and time

startp=startp + 70000; %with sample interval of .1 ms, = 7 sec

endp=length(fhandles.y); 
%endp=200000; 

[damin,damini]=min(fhandles.y(startp:endp));

bl=mean(fhandles.y(startp+damini-10000:startp+damini-9900));

p2=mean(fhandles.y(startp+damini-avgwindow:startp+damini+avgwindow));
p2=p2-bl;

t2=(damini+startp)*fhandles.si;

time=t2-t1;

ratio=p2/p1;







guidata(hFIGURE, fhandles);  %update gui data


function editdeltax_Callback(hObject, eventdata, handles)
% hObject    handle to editdeltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editdeltax as text
%        str2double(get(hObject,'String')) returns contents of editdeltax as a double


% --- Executes during object creation, after setting all properties.
function editdeltax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editdeltax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

    



 
    
    


% % --- Executes on button press in pushbuttonIFcurve.
% function pushbuttonIFcurvebac_Callback(hObject, eventdata, handles)
% % hObject    handle to pushbuttonIFcurve (see GCBO)
% % eventdata  reserved - to be defined in a future version of MATLAB
% % handles    structure with handles and user data (see GUIDATA)
% 
% [hOBJECT, hFIGURE] = gcbo;
% fhandles = guidata(hFIGURE); %retrieve gui data
% 
% 
% thresh=1;
% refract=2;
% 
% 
% testapx=fhandles.x;
% si=testapx(2)-testapx(1);
% 
% start_time=530;%in ms
% end_time=1024;
% 
% aps=figure();
% set(aps, 'Position', [1 1 700 500]);
% 
% % freqs=[nan];
% % threshavg=[nan];
% % thresh=[nan];
% % 
% % 
% % assignin('base','freqs',freqs);
% % assignin('base','threshavg',threshavg);
% % assignin('base','thresh',thresh);
% 
% 
% % for i=1:fhandles.totalsweeps
% for i=1:35
%     
% 
%     
%     
%     testap=fhandles.filedata(:,1,i);
%     
%    i
%     
%     
% 
% 
% %testap=smoothdata(testap);
% 
% 
% 
% testapdiff=diff(testap);
% 
% testapdiff=smoothdata(testapdiff);
% 
% api=[nan];
% apxi=[nan];
% apx2=[nan];
% ISI=[nan];
% apx=[nan];
% apmarker=[nan];
% 
% api=find(testapdiff>thresh);
% 
% 
% 
% 
% 
% 
% if ~isempty(api)
% 
%     
%     for p=1:length(api)
%     
%     if ~isnan(api(p)) 
%     
%      
%         thisvalue=api(p);
%         iwindow=(refract/(si));
%         
%         tooclose=find(api>api(p) & api<(api(p)+iwindow));
%         
%         for j=1:length(tooclose)
%             api(tooclose(j))=nan;
%         end
%    
%     
%     
%     end
%     
%     end
% 
% j=1;
% 
% 
% eventsflag=0;
% 
%     for p=1:length(api)
%     if ~isnan(api(p)) && api(p)>(start_time/si) && api(p) < (end_time/si) &&  max(testap(api(p):api(p)+(refract/si)))>-25
%         thisapi=api(p);
%         apxi(j)=thisapi;
%         apx2(j)=testapx(thisapi);
%         j=j+1;
%         eventsflag=1;
%     end
%     end
% 
%     
% 
% 
% if eventsflag==1 && length(apxi)>1
%     
%     apx=apx2';
%     
%     for p=1:length(apxi)
%     apmarker(p)=testap(apxi(p));
%     end
% 
%     for p=2:length(apx)
%         
%        
%             ISI(p-1)=apx(p)-apx(p-1);
%        
%     end
% 
%     
% 
% ISI=ISI';
% 
% 
% freqs(i)=1/mean(ISI);
% 
% 
% threshavg(i)=mean(apmarker);
% 
% thresh(i)=apmarker(1);
% 
% 
% 
% plot(testapx,testap,apx,apmarker,'o');
% % plot(testapx(1:end-1),testapdiff);
% 
% 
% % axis([110 220 -70 -30]);
% pause(.001);
% 
% end
% 
% end
% 
% end
% 
% 
% 
% 
% 
% 
% 
% 
% 
% freqs=freqs*1000;
% freqs=freqs';
% threshavg=threshavg';
% thresh=thresh';
% 
% 
% 
% 
% 
% assignin('base','freqs',freqs);
% assignin('base','threshavg',threshavg);
% assignin('base','thresh',thresh);



function pushbuttonIFcurve_Callback(hObject, eventdata, ~)
% hObject    handle to pushbuttonIFcurve (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;

fhandles = guidata(hFIGURE); %retrieve gui data
fhandles;
x=fhandles.x;
thresh=fhandles.APthresh;
sweepnum=fhandles.totalsweeps;
refract=3;
si=x(2)-x(1);


diffthresh=0.5;

% start_time=527;%in ms
% end_time=827;

% start_time=117;
% end_time=417;

% start_time=3000;
% end_time=4000;

start_time=fhandles.IFstart;
end_time=fhandles.IFend;

disp('duration of this epoch:')
disp(num2str(end_time-start_time));


for i=1:sweepnum
% for i=28:28


   
    
    y=fhandles.datasweeps(:,i);
    x=fhandles.x;
    api=[nan];
    api=find(y>thresh);
    
    
   
    
%   list of indexes of voltage trace that is above threshold  
    if length(api)>1
        

        apxi=[nan];
        apx2=[nan];
        ISI=[nan];
        apx=[nan];
        apmarkerx=[nan];
        apmarker=[nan];

        for p=1:length(api)

             


                thisvalue=api(p);
                iwindow=(refract/(si));

                tooclose=find(api>api(p) & api<(api(p)+iwindow));

                for j=1:length(tooclose)
                    api(tooclose(j))=nan;
                end



            

        end
    
    
   
    
%calculate ISI from api

j=1;


eventsflag=0;

for p=1:length(api)
if ~isnan(api(p)) && api(p)>(start_time/si) && api(p) < (end_time/si)
        thisapi=api(p);
        apxi(j)=thisapi;
        apx(j)=x(thisapi);
        j=j+1;
        eventsflag=1;
    
end

end


if eventsflag==1 && length(apxi)>0
    
    apx=apx';
    
    
threshevent=1;    



for p=1:length(apxi)
% p=1;



    
    temp=y(apxi(p)-(2/si):apxi(p));
    difftemp=smooth(temp);
    difftemp=diff(difftemp);
    
 
   
    difftempx=[0:si:((length(difftemp)-1)*si)]';
    length(difftemp);
    length(difftempx);
    

%     plot(difftempx,difftemp);
    
    
    threshloc=find(difftemp>diffthresh);  %find thresholds
    
    if ~isnan(threshloc)
        apmarker(threshevent)=temp(threshloc(1));
        %apmarkerx(threshevent)=(threshloc(1)+ (apxi(p)-(1.5/si))-2)*si;
        apmarkerx(threshevent)=(threshloc(1)+ (apxi(p)-round((2.2/si))))*si;
        threshevent=threshevent+1;
    end
end



AHPs=[nan];
Peaks=[nan];
Heights=[nan];
Widths=[nan];

    if(length(apxi)>1)

        for p=2:length(apx)
            
            
            ISI(p-1)=apx(p)-apx(p-1);
            
            
            mintemp=y(apxi(p-1):apxi(p));
            
            %             mintemp=smooth(mintemp);
            AHPs(p-1)=min(mintemp);
            
        end
        
        
    elseif(length(apxi)==1)
       
        firstrowhere=apxi(1);
        lastrowhere=apxi(1) + (50/si);
        
        mintemp=y(firstrowhere:lastrowhere);
        AHPs(1) = min(mintemp);
        ISI(1)=0;
        
        
    end
    
    
    if(length(apxi)>1)
    
        for p=1:length(apmarkerx)-1
            
            mintemp2=y(floor((apmarkerx(p)-.5)/si):floor(apmarkerx(p+1)/si));
            Peaks(p)=max(mintemp2);
            Heights(p)=Peaks(p)-apmarker(p);
            
            
            
            
            halfthresh=(Heights(p)/2)+apmarker(p);
            
            
            
            
            widthx=find(mintemp2>halfthresh);
            
            widthhere=length(widthx)*si;
            
            Widths(p)=widthhere;
        end
    elseif(length(apxi)==1)
           
            mintemp2=y(floor((apmarkerx(1)-.5)/si):floor((apmarkerx(1) + 5)/si));
            Peaks(1)=max(mintemp2);
            Heights(1)=Peaks(1)-apmarker(1);
            
            
            
            
            halfthresh=(Heights(1)/2)+apmarker(1);
            
            
            
            
            widthx=find(mintemp2>halfthresh);
            
            widthhere=length(widthx)*si;
            
            Widths(1)=widthhere; 
        
    end
                
    

    
Thresh1(i)=apmarker(1);
AvgThresh(i)=mean(apmarker);

    
AHP1(i)=AHPs(1);
AvgAHP(i)=mean(AHPs);

if length(apxi)>1

freqs(i)=1/mean(ISI);


APnums(i)=length(apmarker);
CVs(i)=std(ISI)/mean(ISI);

    

AvgPeak(i)=mean(Peaks);
AvgWidth(i)=mean(Widths);
AvgHeight(i)=mean(Heights);

elseif length(apxi)==1
    
    freqs(i)=0;


    APnums(i)=1;
    CVs(i)=0;

    

    AvgPeak(i)=Peaks(1);
    AvgWidth(i)=mean(Widths);
    AvgHeight(i)=mean(Heights);

    
end
    
    
if(length(apmarkerx)>length(apmarker))
    apmarkerx=apmarkerx(1:length(apmarker));
elseif (length(apmarkerx)<length(apmarker))
    apmarker=apmarker(1:length(apmarkerx));
end

    
plot(x,y,apmarkerx,apmarker,'o');
% plot(x,y);

axis([start_time-20 end_time+20 -inf inf]);
pause(.1);    

    end
    
    Baselines(i)=mean(y((start_time-20)/si:(start_time-5)/si));
    
    AHP_window=150;
    %AHP_window=400;
    
    [Burst_AHPs(i),min_i] = min(y((end_time+10)/si:(end_time+AHP_window)/si));
    Burst_AHPs(i)=Burst_AHPs(i)-Baselines(i);
    

    if (length(api)>0)
    
    AHP_times(i)=(min_i*si) + 10;
    
    else
        
        AHP_times(i)=" ";
    
    end
    
  

    Burst_ADPs(i)=max(y((end_time+10)/si:((end_time+10)/si) + min_i))-Baselines(i);
    
    
    end
end


ISI=ISI';
CVs=CVs';

AHP_times=AHP_times';
freqs=freqs';
APnums=APnums';
freqs=freqs*1000;
AHPs=AHPs';
AHP1=AHP1';
AvgAHP=AvgAHP';
AvgThresh=AvgThresh';
Thresh1=Thresh1';
AvgPeak=AvgPeak';
AvgWidth=AvgWidth';
AvgHeight=AvgHeight';
Baselines=Baselines';
Burst_AHPs=Burst_AHPs';
Burst_ADPs=Burst_ADPs';


Everything(:,1)=Baselines;
Everything(:,2)=freqs;
Everything(:,3)=APnums;
Everything(:,4)=Burst_ADPs;
Everything(:,5)=Burst_AHPs;
Everything(:,6)=CVs;
Everything(:,7)=AvgThresh;
Everything(:,8)=AvgAHP;


assignin('base','Everything_names',{'Baselines','freqs','APnums','Burst_ADPs','Burst_AHPs','CVs','AvgThresh','AvgAHP'})

assignin('base','Everything',Everything);

assignin('base','CVs',CVs);
assignin('base','Baselines',Baselines);
assignin('base','Burst_AHPs',Burst_AHPs);
assignin('base','Burst_ADPs',Burst_ADPs);
assignin('base','AHP_times',AHP_times);

assignin('base','freqs',freqs);
assignin('base','APnums',APnums);
assignin('base','Thresh1',Thresh1);
assignin('base','AvgThresh',AvgThresh);
assignin('base','AHP1',AHP1);
assignin('base','AvgAHP',AvgAHP);
assignin('base','AvgPeak',AvgPeak);
assignin('base','AvgWidth',AvgWidth);
assignin('base','AvgHeight',AvgHeight);




% assignin('base','threshavg',threshavg);
% assignin('base','thresh',thresh);
    

    
    













    
   
    



function APthreshedit_Callback(hObject, eventdata, handles)
% hObject    handle to APthreshedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of APthreshedit as text
%        str2double(get(hObject,'String')) returns contents of APthreshedit as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.APthresh=str2num(get(fhandles.APthreshedit,'String'));


guidata(hFIGURE, fhandles);  %update handles structure



% --- Executes during object creation, after setting all properties.
function APthreshedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to APthreshedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editIFend_Callback(hObject, eventdata, handles)
% hObject    handle to editIFend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIFend as text
%        str2double(get(hObject,'String')) returns contents of editIFend as a double
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.IFend=str2num(get(fhandles.editIFend,'String'));


guidata(hFIGURE, fhandles);  %update handles structure


% --- Executes during object creation, after setting all properties.
function editIFend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIFend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editIFstart_Callback(hObject, eventdata, handles)
% hObject    handle to editIFstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editIFstart as text
%        str2double(get(hObject,'String')) returns contents of editIFstart as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.IFstart=str2num(get(fhandles.editIFstart,'String'));


guidata(hFIGURE, fhandles);  %update handles structure


% --- Executes during object creation, after setting all properties.
function editIFstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editIFstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editsagstart_Callback(hObject, eventdata, handles)
% hObject    handle to editsagstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editsagstart as text
%        str2double(get(hObject,'String')) returns contents of editsagstart as a double
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.sagstart=str2num(get(fhandles.editsagstart,'String'));


guidata(hFIGURE, fhandles);  %update handles structure

% --- Executes during object creation, after setting all properties.
function editsagstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editsagstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editsagend_Callback(hObject, eventdata, handles)
% hObject    handle to editsagend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editsagend as text
%        str2double(get(hObject,'String')) returns contents of editsagend as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.sagend=str2num(get(fhandles.editsagend,'String'));


guidata(hFIGURE, fhandles);  %update handles structure
% --- Executes during object creation, after setting all properties.
function editsagend_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editsagend (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushsag.
function pushsag_Callback(hObject, eventdata, handles)
% hObject    handle to pushsag (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;

fhandles = guidata(hFIGURE); %retrieve gui data


start_time=fhandles.sagstart;
end_time=fhandles.sagend;
si=fhandles.si;

for i=1:fhandles.totalsweeps
   
    sag_sweep=fhandles.datasweeps(:,i);
    
    
    
    bl=mean(sag_sweep((start_time-20)/si:(start_time-2)/si));
    
    sag_sweep=sag_sweep-bl;
    
    sag_sweep=smooth(sag_sweep);
    
    peak=min(sag_sweep(start_time/si:(start_time+200)/si));
    
    endavg=mean(sag_sweep((end_time-50)/si:(end_time-5)/si));
    
    peaks(i)=peak;
    avgs(i)=endavg;
    sagratio(i)=peak/endavg;
   
    
end

peaks=peaks';
avgs=avgs';
sagratio=sagratio';


assignin('base','peaks',peaks);
assignin('base','avgs',avgs);
assignin('base','sagratio',sagratio);
    
    
    
    




guidata(hFIGURE, fhandles);  %update handles structure


% --- Executes on button press in capmeasurebutt.
function capmeasurebutt_Callback(hObject, eventdata, handles)
% hObject    handle to capmeasurebutt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

si=fhandles.si;



dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

temphere=(fhandles.y((csrx/si):(55/si)));
temphere=0;

for g=1:fhandles.totalsweeps

temphere=temphere + fhandles.datasweeps((csrx/si):(55/si),g);

end

% temphere=abs(temphere);

temphere=temphere/fhandles.totalsweeps;

bl=mean(fhandles.y(3/si:4/si));

temphere=temphere-bl;

temphere=abs(temphere);

figure();



x=(0:si:(length(temphere)-1)*si)';



a_est=mean(temphere(length(temphere)-20:length(temphere)));

b_est=(temphere(1)-a_est)*0.1;
c_est=.1;

d_est=(temphere(1)-a_est)*.9;
e_est=.05;



g = fittype('a+(b*exp(-c*x))+(d*exp(-e*x))');
options=fitoptions(g);
options.StartPoint=[a_est b_est c_est d_est e_est];
f=fit(x,temphere,g,options);



plot(f,x,temphere);


tau1=1/f.c;
tau2=1/f.e;

if tau1>tau2
    ttemp=tau1;
    tau1=tau2;
    tau2=ttemp;
end

disp('cell tau:');
tau2

disp(' ');
disp(' ');


Rin=(10/f.a)*1e3 %10 mV step, eg 200 pA steady state
                 % so (10 * 1e-3)/(200 * 1e-12) puts it at .05 Gohm, or 50
                 % mohm
disp('MegaOhms');

disp(' ');
disp(' ');


Cap_cell=((tau2/1000)/(Rin*1e6))*1e12 %converted rin to ohms,time to sec.
                                      % multiplying of 1e12 gives pF
disp('pF');



% 
% axis([-5 50 -inf inf]);
% 


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data




% end_time=fhandles.IFend;

dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

fhandles.IFstart=csrx;

set(fhandles.editIFstart,'String',num2str(csrx));

guidata(hFIGURE, fhandles);  %update handles structure




% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data




% end_time=fhandles.IFend;

dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

fhandles.IFend=csrx;

set(fhandles.editIFend,'String',num2str(csrx));

guidata(hFIGURE, fhandles);  %update handles structure


% --- Executes on button press in MeasureCapbutton.
function MeasureCapbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MeasureCapbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

si=fhandles.si;



dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

temphere=(fhandles.y((csrx/si):(55/si)));
temphere=0;

for g=1:fhandles.totalsweeps

temphere=temphere + fhandles.datasweeps((csrx/si):(55/si),g);

end

% temphere=abs(temphere);

temphere=temphere/fhandles.totalsweeps;

bl=mean(fhandles.y(3/si:4/si));

temphere=temphere-bl;

temphere=abs(temphere);

figure();



x=(0:si:(length(temphere)-1)*si)';



a_est=mean(temphere(length(temphere)-20:length(temphere)));

b_est=(temphere(1)-a_est)*0.1;
c_est=.1;

d_est=(temphere(1)-a_est)*.9;
e_est=.05;



g = fittype('a+(b*exp(-c*x))+(d*exp(-e*x))');
options=fitoptions(g);
options.StartPoint=[a_est b_est c_est d_est e_est];
f=fit(x,temphere,g,options);



plot(f,x,temphere);


tau1=1/f.c;
tau2=1/f.e;

if tau1>tau2
    ttemp=tau1;
    tau1=tau2;
    tau2=ttemp;
end

disp('cell tau:');
tau2

disp(' ');
disp(' ');


Rin=(10/f.a)*1e3 %10 mV step, eg 200 pA steady state
                 % so (10 * 1e-3)/(200 * 1e-12) puts it at .05 Gohm, or 50
                 % mohm
disp('MegaOhms');

disp(' ');
disp(' ');


Cap_cell=((tau2/1000)/(Rin*1e6))*1e12 %converted rin to ohms,time to sec.
                                      % multiplying of 1e12 gives pF
disp('pF');

assignin('base','Cap_cell',Cap_cell);
assignin('base','Rin',Rin);

% 
% axis([-5 50 -inf inf]);
% 


% --- Executes on button press in expfitbutton.
function expfitbutton_Callback(hObject, eventdata, handles)
% hObject    handle to expfitbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

si=fhandles.si;



dcm_obj = datacursormode(hFIGURE);
csrinfo=getCursorInfo(dcm_obj);

field=fieldnames(csrinfo);

csrpos=getfield(csrinfo,field{2});

csrx=csrpos(1);

leng=fhandles.expfitlength;



temphere=fhandles.y(csrx/si:(csrx+leng)/si);
x=(0:si:(length(temphere)-1)*si)';

figure();
plot(x,temphere)


bl=mean(fhandles.y((length(temphere)-7)/si:(length(temphere)-5)/si));


temphere=temphere-bl;

temphere=abs(temphere);








% for g=1:fhandles.totalsweeps
% 
% temphere=temphere + fhandles.datasweeps((csrx/si):((csrx+leng)/si),g);
% 
% end
% 
% % temphere=abs(temphere);
% 
% temphere=temphere/fhandles.totalsweeps;







a_est=mean(temphere(length(temphere)-5:length(temphere)));


b_est=(temphere(1)-a_est);
%b_est = 1;
c_est = .01;

d_est = b_est;
e_st=.01;







g = fittype('a+(b*exp(-c*x)) + (d*exp(-e*x))');
options=fitoptions(g);
options.StartPoint=[a_est b_est c_est d_est e_st];
f=fit(x,temphere,g,options);



plot(f,x,temphere);


tau1=1/f.c;
tau2=1/f.e;





tau1
tau2
disp(' ');
disp(' ');



function expfitlength_text_Callback(hObject, eventdata, handles)
% hObject    handle to expfitlength_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of expfitlength_text as text
%        str2double(get(hObject,'String')) returns contents of expfitlength_text as a double
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.expfitlength=str2num(get(fhandles.expfitlength_text,'String'));


guidata(hFIGURE, fhandles);  %update handles structure



% --- Executes during object creation, after setting all properties.
function expfitlength_text_CreateFcn(hObject, eventdata, handles)
% hObject    handle to expfitlength_text (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in STPbutton.
function STPbutton_Callback(hObject, eventdata, handles)
% hObject    handle to STPbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



[hOBJECT, hFIGURE] = gcbo;

fhandles = guidata(hFIGURE); %retrieve gui data
fhandles;
x=fhandles.x;
sweepnum=fhandles.totalsweeps;
si=fhandles.si;

blstart=620/si;
blend=640/si;
p1start=floor(643/si);
p1end=floor(646.2/si);

p2start=663/si;
p2end=672/si;

avgwindow=5;


j=1;

for i=1:sweepnum

y=fhandles.datasweeps(:,i);
x=fhandles.x;
    
bl=mean(y(blstart:blend));

[damin,damini]=min(y(p1start:p1end));


p1=mean(y(p1start+damini-avgwindow:p1start+damini));


[damin,damini]=min(y(p2start:p2end));
p2=mean(y(p2start+damini-avgwindow:p2start+damini));

ratio=(p2-bl)/(p1-bl);

%  if((p1-bl)<-15 && ratio<50)


 ampsratios(1,j) =p1-bl;
 p2s(j)=p2-bl;
 
 ampsratios(2,j)=ratio;
    j=j+1;
  
%  end

 
end


ampsratios=ampsratios';
p2s=p2s';

avgs=mean(ampsratios);


assignin('base','ampsratios',ampsratios);
assignin('base','p2s',p2s);
assignin('base','avgs',avgs);


% --- Executes on button press in radioappendpeak.
function radioappendpeak_Callback(hObject, eventdata, handles)
% hObject    handle to radioappendpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radioappendpeak

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

appendflag=get(hObject,'Value');

fhandles.appendpeakflag=appendflag;


 guidata(hFIGURE, fhandles);  %update gui data


% --- Executes during object creation, after setting all properties.
function buttonpeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to buttonpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.analysis_peak=[];


guidata(hFIGURE, fhandles);  %update gui data


% --- Executes during object creation, after setting all properties.
function radioappendpeak_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radioappendpeak (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.appendpeakflag=1;


guidata(hFIGURE, fhandles);  %update gui data



function filepathedit_Callback(hObject, eventdata, handles)
% hObject    handle to filepathedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of filepathedit as text
%        str2double(get(hObject,'String')) returns contents of filepathedit as a double
[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

filepath=get(fhandles.filepathedit,'String');

fhandles.pathname=filepath;



guidata(hFIGURE, fhandles);  %update gui data

% --- Executes during object creation, after setting all properties.
function filepathedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to filepathedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data



fhandles.pathname='C:\';



guidata(hFIGURE, fhandles);  %update gui data


% --- Executes on button press in MultiPeaksbutton.
function MultiPeaksbutton_Callback(hObject, eventdata, handles)
% hObject    handle to MultiPeaksbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)





[hOBJECT, hFIGURE] = gcbo;

fhandles = guidata(hFIGURE); %retrieve gui data
fhandles;
x=fhandles.x;
y=fhandles.y;
sweepnum=fhandles.totalsweeps;
si=fhandles.si;

starttime=fhandles.MultiPeakstart;
freq=fhandles.MultiPeakfreq;
ISI=1000/freq;

blstart=(starttime-14)/si;
blend=(starttime-4)/si;

pulsenum=8;

averagemin=-50;
averagemax=-200;

avgnum=0;

avgs(1:pulsenum) = 0;
avgs=avgs';

for i=1:sweepnum
    
    bl=mean(y(blstart:blend));
    
    for j=1:pulsenum

        startp=(starttime + 0.5 + ((j-1)*ISI))/si;
        endp=(starttime + (j*ISI)-3)/si;
        
        
        y=fhandles.datasweeps(:,i);
        x=fhandles.x;
    


        [damin,damini]=min(y(startp:endp));
        [damax,damaxi]=max(y(startp:endp));
        
        if abs(damin)>damax
            peaks(j,i)=damin-bl;
        else
            peaks(j,i)=damax-bl;
        end


        



    end
    
%     if(peaks(1,i)<=averagemin && peaks(1,i)>=averagemax)
%         avgnum = avgnum + 1;
%         avgs(:)=avgs + peaks(:,i);
%        
%     end



end
  
avgs=mean(peaks,2);

name=fhandles.filename;
name(length(name)-3:length(name))=[];





%name=strcat('peaks',name);


%assignin('base',name,peaks);
assignin('base','peaks',peaks)
assignin('base','avgs',avgs);
assignin('base','filename',name);
assignin('base','thisfreq',freq);





function editMultiPeakstart_Callback(hObject, eventdata, handles)
% hObject    handle to editMultiPeakstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editMultiPeakstart as text
%        str2double(get(hObject,'String')) returns contents of editMultiPeakstart as a double

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.MultiPeakstart=str2num(get(fhandles.editMultiPeakstart,'String'));


guidata(hFIGURE, fhandles);  %update handles structure


% --- Executes during object creation, after setting all properties.
function editMultiPeakstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMultiPeakstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function editMultiPeakfreq_Callback(hObject, eventdata, handles)
% hObject    handle to editMultiPeakfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[hOBJECT, hFIGURE] = gcbo;
fhandles = guidata(hFIGURE); %retrieve gui data

fhandles.MultiPeakfreq=str2num(get(fhandles.editMultiPeakfreq,'String'));


guidata(hFIGURE, fhandles);  %update handles structure


% Hints: get(hObject,'String') returns contents of editMultiPeakfreq as text
%        str2double(get(hObject,'String')) returns contents of editMultiPeakfreq as a double


% --- Executes during object creation, after setting all properties.
function editMultiPeakfreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editMultiPeakfreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
