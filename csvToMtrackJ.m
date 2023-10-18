function csvToMtrackJ(rootDir,fileName,csvPath,cropFromEdge,startFrame,minlength,pixSizeX,pixSizeZ)
    trackData = CSVimport(csvPath,'Track_ID','x','y','z','Frame',1,1,1); %timeMultiplier,umXYmultiplier,umZmultiplier)

    txtfile = (fullfile(rootDir,[fileName '.mdf']));
    fid = fopen(txtfile,'wt');
    fprintf(fid,'MTrackJ 1.5.0 Data File \n');
    fprintf(fid,'Assembly 1\n');
    fprintf(fid,'Cluster 1\n');
    b=0;
%     for track = 1:length(trackData)
%         curTrack = trackData(track);
%         if(any(curTrack.inMask))
%             trackData(track).trackInMask = 1;
%             b=b+1;
%         else
%             trackData(track).trackInMask = 0;
%         end
%         
%     end
%     disp(['number of tracks inside is:' num2str(b) ' in total:' num2str(length(trackData))]);
    for track = 1:length(trackData)
        curTrack = trackData(track);
        if (length(curTrack.frames)<minlength)
            continue
        end
        trackID = curTrack.trackID;
        fprintf(fid,['Track ',num2str(trackID),'\n']);
        
        x =  curTrack.pos_xyz(:,1);
        y =  curTrack.pos_xyz(:,2);
        z =  curTrack.pos_xyz(:,3);
        frames = curTrack.frames+startFrame;
        %inMask = curTrack.inMask;
        
        for j=1:length(x)
            fprintf(fid,['Point ',num2str(j),' ',num2str((x(j)/pixSizeX)+cropFromEdge),' ',num2str((y(j)/pixSizeX)+cropFromEdge),' ',num2str((z(j)/pixSizeZ)+2),' ',num2str(frames(j)+1),' 1\n']);
        end
    end
    
    fprintf(fid,'End of MTrackJ File');
    fclose(fid);
      
    
end

