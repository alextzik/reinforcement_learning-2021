##########################################################
"""
    Nesessary Packages
"""
# Printing
using Printf

# Dataset reading
using DataFrames
using Pkg
Pkg.add("CSV")
using CSV

##########################################################
"""
    Change directory
"""
dir = "/Users/AlexandrosTzikas/Desktop/project 2"
cd(dir)

##########################################################
"""
    Create an input dataframe and an output file
"""
infile = DataFrame(CSV.File("large.csv"))
outfile = "large.policy"

##########################################################
"""
    Necessary functions 
"""

# Policy Output File Creation
function write_policy(actions, filename)
    open(filename, "w") do io
        for a in actions
            @printf(io, "%s\n", a)
        end
    end
end

# Necessary structure
struct QLearning
    S # state space size 
    A # action space size
    gamma # discount
    Q # action value function of size (|S|,|A|)
    a # learning rate
end

# update the Q estimates after with the observed transitions
function update!(model::QLearning, D)
    k_max = 200 # number of dataset passes

    # update Q-learning table with multiple passes over dataset
    for k in 1:k_max

        # Q-learning update step for each observation
        for i = 1:size(D,1)
            s = D[i, 1]
            a = D[i, 2]
            r = D[i, 3]
            sp = D[i, 4]
            
            model.Q[s,a] += model.a*(r + model.gamma*maximum(model.Q[sp,:])-model.Q[s,a])
        end
    end
    return model
end

function find_policy(model::QLearning)
    actions = zeros(model.S, 1)
    for s in 1:model.S
        u, a = findmax(a->model.Q[s,a], [i for i in 1:model.A])
        actions[s, 1] = a
    end
    return actions
end

##########################################################
"""
    Main Function
"""
function compute(infile, outfile)
    # Input details - must change for each dataset!!!!
    nOfStates = 312020
    nOfActions = 9
    gamma = 0.95
    a = 0.1

    # Instantiate the model estimate using the Q-learning structure
    model = QLearning(nOfStates, nOfActions, gamma, zeros(nOfStates,nOfActions), a)

    # Update the model estimate 
    model = update!(model, infile)

    # Find policy
    actions = find_policy(model)

    # Write policy to output file
    write_policy(actions, outfile)

end

@time begin
    compute(infile, outfile)
end