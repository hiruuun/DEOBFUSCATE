function scores_indviz = eval_single_sol_revisit1(sol,scenario,cruise,rd,b)
% evaluate fitness

%   The arguments to the function are 
%     sol: single solution string
%     scenario: floor plan scenerio
%     v1: robot object 
%     ul: upper left box object
%     ur: uper right box object
%     bl:bottom left box object 
%     br: bottom right box object

update_cruise = sol_to_cruise(sol,cruise);

car.mass=400;
friction=5.0;
car.x=50;
car.y=50;
car.z=3;
car.v=0;
g=9.8;
tick=0.05;
target_speed=15;
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
ForceChange_list=[];



for pos=1:800
speed_error= current_speed-target_speed;
sp_er=[sp_er speed_error];
% GET FORCE CHANGE
ForceChange=evalfis(update_cruise,[speed_error,acceleration]);
if ForceChange==0
    hhh=1;
end
ForceChange_list=[ForceChange_list ForceChange];
force=force+ForceChange;

for_ch=[for_ch force];
prev_speed=current_speed;
%update car force. current theta base on current_X.tick
newX= current_X+ cos(thetas(loc))*current_speed*tick;
newV= current_speed+(((force-friction)*current_speed)/car.mass-g*sin(thetas(loc)))*tick;
if newV<0
%     newV=0
end

current_X=newX;
current_speed=newV;
cur_sp=[cur_sp current_speed];
acceleration= (current_speed-prev_speed)/tick;
acc_ch=[acc_ch acceleration];
tar_sp=[tar_sp target_speed];

if current_X<1
    loc=1;
    current_X=1;
%     disp(" You can not go backwards.")
%     disp("It means you are getting too much negative acceleration.")
%     disp("you may required to put more force")
    %return
end

loc=floor(current_X);

if loc > size(b,1)-1  %stopping condition, comleted the car loop may we can run two rounds
    current_X=1;
    loc=1;
    
end

%v1.Position= b(loc,:);%[10 0 10];

if  abs(speed_error)<=15.00 && abs(acceleration)<=20
%pause(.1/current_speed)
else
%  disp("out of range current_speed")
%  disp("***************out of range******************")
 %pause(.1)
%  speed_error
%  acceleration

 break;
end


end



    
   
    %% Socre With Moves
    if abs(speed_error)>15.00 || abs(acceleration)>20.00
        fitness=mean(abs(sp_er))*500;%+mean(abs(for_ch));
    else
    fitness=mean(abs(sp_er));     %+mean(abs(for_ch))*10; 
    end
 
        
   


scores_indviz=fitness;
end