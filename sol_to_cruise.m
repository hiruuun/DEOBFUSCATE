function update_cruise = sol_to_cruise(sol,cruise)
    
    for i=1:9
    cruise.Outputs.MembershipFunctions(i).Parameters=sol(i);
    end


    update_cruise=cruise;

