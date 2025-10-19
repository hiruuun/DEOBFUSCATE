function scores = robot_fitness(x,scenario,cruise,rd,b)
%T Custom fitness function Calculate the fitness 
%   of an individual.


scores = zeros(size(x,1),1);
for j = 1:size(x,1)
    % here is where the special knowledge that the population is a cell
    % array is used. Normally, this would be pop(j,:);
    p_pop = x{j}; 
      
    scores(j) = eval_single_sol_revisit1(p_pop,scenario,cruise,rd,b); %eval_single_sol_revisit
end