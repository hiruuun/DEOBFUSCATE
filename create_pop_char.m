function pop = create_pop_char(NVARS,FitnessFcn,options) %FitnessFcn,)
%CREATE_PERMUTATIONS Creates a population of permutations.
%   POP = CREATE_PERMUTATION(NVARS,FITNESSFCN,OPTIONS) creates a population
%  of permutations POP each with a length of NVARS. 
%
%   The arguments to the function are 
%     NVARS: Number of variables 
%     FITNESSFCN: Fitness function 
%     OPTIONS: Options structure used by the GA

totalPopulationSize = sum(options.PopulationSize);

n = NVARS;
tmp=zeros(1,n);
pop = cell(totalPopulationSize,1);
totalPopulationSize
for i = 1:totalPopulationSize
   

%     newp{1}=[cruise.Inputs(1).MembershipFunctions(1).Parameters ;cruise.Inputs(1).MembershipFunctions(2).Parameters;cruise.Inputs(1).MembershipFunctions(3).Parameters]
%  
%     newp{2}=[cruise.Inputs(2).MembershipFunctions(1).Parameters ;cruise.Inputs(2).MembershipFunctions(2).Parameters;cruise.Inputs(2).MembershipFunctions(3).Parameters]

    pop{i} = randi([-1000,1000],1,9);
end
