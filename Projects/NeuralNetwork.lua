-- Neural Network Library
local NN = {}

-- Constants
NN.COST_FUNCTION_MSE = "MSE"
NN.ACTIVATION_FUNCTION_SIGMOID = "sigmoid"

-- Default values
NN.DEFAULT_LEARNING_RATE = 0.1
NN.DEFAULT_COST_FUNCTION = NN.COST_FUNCTION_MSE
NN.DEFAULT_ACTIVATION_FUNCTION = NN.ACTIVATION_FUNCTION_SIGMOID

-- Neural network properties
NN.layers = {}
NN.weights = {}
NN.biases = {}
NN.activations = {}
NN.learningRate = NN.DEFAULT_LEARNING_RATE
NN.cost = 0
NN.costFunction = NN.DEFAULT_COST_FUNCTION
NN.activationFunction = NN.DEFAULT_ACTIVATION_FUNCTION

-- Returns the value of a property of the neural network
function NN:get(property)
    if self[property] then
        return self[property]
    else
        error("Property '" .. property .. "' does not exist in the neural network")
    end
end

-- Sets the value of a property of the neural network
function NN:set(property, value)
    if self[property] then
        self[property] = value
    else
        error("Property '" .. property .. "' does not exist in the neural network")
    end
end

-- Feeds the input through the neural network and returns the output
function NN:feedforward(input)
    -- Make a copy of the input
    local output = input:clone()

    -- Loop through the layers of the neural network
    for i = 1, #self.layers do
        -- Calculate the weighted sum of the input and biases
        local z = self.weights[i] * output + self.biases[i]

        -- Apply the activation function to the weighted sum
        output = self:applyActivation(z, self.activationFunction)
    end

    -- Return the output
    return output
end

-- Applies an activation function to a tensor

