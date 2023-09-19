%unused class definition
classdef pC_Data < handle
    properties
        filename
        pathname
        sweepnum
        
        filedata
        si
        finfo
        
        
        x
        y 
    end
    
    methods
         function load_file(obj)

             localname=strcat(obj.pathname,obj.filename);
             
             [d,si,h]=abfload(localname);
             obj.filedata=d;
             obj.si=si;
             obj.finfo=h;
             
             obj.y=d(:,obj.sweepnum);
             obj.x=(0:si:(length(d(:,1))-1)*si);
             plot(obj.x,obj.y);
         end
    end
end

