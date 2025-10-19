
 clear
 close all 
 

% The Problem 
% Our goal is to evolve GA to find optimal values of forcechange vairable
% in fuzzy system 
% we generate a cruise control fuzzy system

%% we generate scene

bump_scene %flat_scene %
start_scene


cruise=readfis('cruise.fis');




% plot(scenario);
% title('Scenario');

%% Required Functions
% %% create_pop_char.m       
%to create random populations

%% crossover_pop.m
% The custom crossover function takes a cell array, the population, and
% returns a cell array, the children that result from the crossover.

%% mutate_pop_char.m
% The custom mutation function takes an individual, which is an ordered set
% of moves, and returns a mutated ordered set.

%% robot_fitness.m
% We also need a fitness function. The
% fitness of an individual is the total boxes visited in certian manner or
% in least moves

%%
% |ga| will call our fitness function with just one argument |x|, but our
% fitness function has multiple arguments:x,scenario,v1,ul,ur,bl,br . We can use an
% anonymous function to capture the values of the additional argument, the
% distances matrix. We create a function handle |FitnessFcn| to an
% anonymous function that takes one input |x|, but calls
% |traveling_salesman_fitness| with |x|, and distances. The variable,
% distances has a value when the function handle |FitnessFcn| is created,
% so these values are captured by the anonymous function.
%distances defined earlier
FitnessFcn = @(x) robot_fitness(x,scenario,cruise,rd,b);

%% Genetic Algorithm Options Setup
% First, we will create an options container to indicate a custom data type
% and the population range.
options = optimoptions(@ga, 'CreationFcn',@create_pop_char);
%     'PopulationType', 'custom','InitialPopulationRange',      [1;9]);

%% 'PlotFcn', my_plot, @mutate_pop
% We choose the custom creation, crossover, mutation, and plot functions
% that we have created, as well as setting some stopping conditions.
options = optimoptions(options,'CreationFcn',@create_pop_char, ...
                        'CrossoverFcn',@crossover_pop, ...
                        'CrossoverFraction',0.8,...
                        'MutationFcn', {@mutate_pop_char, 0.2}, ...
                        'MaxGenerations',200,'PopulationSize',30, ...
                        'MaxStallGenerations',20,'UseVectorized',true ...
                         ,'PlotFcn', {@gaplotbestf} ...
                         ,'Display',"iter" ...  
                           );
%,'Display',"iter" ...    ,
                                              
%%
% Finally, we call the genetic algorithm with our problem information.

numberOfVariables = 9;
[bestsol,fval,reason,output] = ...
    ga(FitnessFcn,numberOfVariables,[],[],[],[],[],[],[],options);


 %% running the best solution
 update_cruise = sol_to_cruise(bestsol{1},cruise);
%  runsol_show(bestsol{1},scenario,v1,ul,ur,bl,br); 

run_sim


figure,plot(ForceChange_list)
ForceMean=mean(abs(ForceChange_list))
ErrorMean=mean(abs(sp_er))


 
