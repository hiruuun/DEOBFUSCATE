car.mass=400;
friction=5.0;
car.x=50;
car.y=50;
car.z=3;
car.v=0;
g=9.8;
tick=0.05;
target_speed=15
current_speed=5;
force=10;


x_axis=size(rd,1);
x_axis=[1:1:x_axis]';
prev=x_axis(1);
slope=[];


for i=2:size(rd,1)
    slp= (rd(i)-rd(prev))/(i-prev);
    prev=i;
    
    slope=[slope slp];
end
thetas=atan(slope);



%% loop
%%  initialization

current_X=1;
loc=1;
car.v=current_speed;
force = 100;%car.mass*g*sin(thetas(loc)) + friction*current_speed;
friction=5.0;
acceleration=0;
sp_er=[];
cur_sp=[];
for_ch=[];
acc_ch=[];
tar_sp=[];
ForceChange_list=[]

for pos=1:800
speed_error= current_speed-target_speed;
sp_er=[sp_er speed_error];
% GET FORCE CHANGE
ForceChange=evalfis(cruise,[speed_error,acceleration]);
ForceChange_list=[ForceChange_list ForceChange];
force=force+ForceChange;

for_ch=[for_ch force];
prev_speed=current_speed;
%update car force. current theta base on current_X.tick
newX= current_X+ cos(thetas(loc))*current_speed*tick;
newV= current_speed+((force-friction*current_speed)/car.mass-g*sin(thetas(loc)))*tick;

current_X=newX;
current_speed=newV;
cur_sp=[cur_sp current_speed];
acceleration= (current_speed-prev_speed)/tick;
acc_ch=[acc_ch acceleration];
tar_sp=[tar_sp target_speed];

if current_X<1
    loc=1;
    current_X=1;
    disp(" You can not go backwards.")
    disp("It means you are getting too much negative acceleration.")
    disp("you may required to put more force")
    return
    
    
end

loc=floor(current_X);





if loc > size(b,1)-1  %stopping condition, comleted the car loop may we can run two rounds
    current_X=1;
    loc=1;
    
end

v1.Position= b(loc,:);%[10 0 10];

if current_speed>-100 && current_speed <100
pause(.1/current_speed)
else
 disp("out of range current_speed")
 disp("***************out of range******************")
 pause(.1)
end

updatePlots(scenario);

plot(cur_sp(:),'b','Parent',hAxes2)
plot(tar_sp(:),'g','Parent',hAxes2)
plot(acc_ch(:),'k','Parent',hAxes2)
plot(sp_er(:),'r','Parent',hAxes2)
legend(hAxes2,{'error','current speed','target speed', 'current acceleration'},'Location','NorthWestOutside')

hold(hAxes2,'on')
drawnow;
end


