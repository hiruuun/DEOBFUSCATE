
% Scene population
% Creating small step for movements
old=roadCenters(1,:);
c=[];
b=[];
for i=2:size(roadCenters,1)
    next=roadCenters(i,:);
    diff=(next-old);
    sizes=abs([(old(1,1)-next(1,1)) (old(1,2)-next(1,2)) (old(1,3)-next(1,3))]);
    
    [rep, idx] = max(sizes);
    
   
      if diff(1) == 0  
        p1= repmat(old(1,1),1,rep+1);
       else 
        p1=[old(1,1):diff(1)/rep:next(1,1) ] ;
      end
        
    if diff(2) == 0  
        p2= repmat(old(1,2),1,rep+1);
    else 
        p2=[old(1,2):diff(2)/rep:next(1,2)];
    end
        
    if diff(3) == 0  
        p3= repmat(old(1,3),1,rep+1);
       else 
      p3=[old(1,3):diff(3)/rep:next(1,3)];
    end
   
    
    
    
    C = cat(1,p1(1:end-1),p2(1:end-1),p3(1:end-1));
    
    b=horzcat(b,C);
    old=next;
    
end
b=b';


roadWidth = 6;
%Car dimensions
v1 = vehicle(scenario,'ClassID',2,'Position',[0 0 3],'Velocity',[0 0 0], 'Length',1.2,'Width',3.2,'Height',3,'PlotColor','red');
road(scenario, roadCenters, 'lanes',lanespec([1 2]));

% plot(scenario,'RoadCenters','off');
% view(30,24)
% pause(5)
v1.Position= [190 221 3];
% updatePlots(scenario);
% pause(3)

% rWayPoints = [repmat(b(1:end-1,:),2,1); b(1,:)];
rd=b(:,3);
figure,plot(rd)
title('1-D view of terrain')
% smoothTrajectory(v1,rWayPoints(:,:), 10);




% for i=1:size(rWayPoints,1)
%     
%     pause(scenario.SampleTime)
%     v1.Position= rWayPoints(i,:);
%     updatePlots(scenario);
%     
% end