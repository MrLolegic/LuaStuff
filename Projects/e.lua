--// Neural Network Concept made by Mr Lolegic \\--
--// This concept was made for people who want to try and make a neural network in lua. \\--
--// This is a fully working neural network \\--

--[[

-- Tiny explanation 

Neural Networks are a machine learning algorithm that is used to recognize patterns.
You're probably wondering "Mr Lolegic please tell me what the fuck is a neural network 
WRITTEN in lua useful????". Well, for one it shows how capable lua is, and for two a neural
network can be used for so many cool things, and three it's just a fun project to work on.

]]--

--// Neural Network Library \\--
local NN = setmetatable(
    { --// Neural Network Library
        layers = {};
        weights = {};
        biases = {};
        activations = {};
        learningRate = 0.1;
        cost = 0;
        costFunction = "MSE";
        activationFunction = "sigmoid";
    },
    { --// Metatable
        __index = function(self, index) --// Get the index of the Neural Network Library
            if self[index] then --// If the index exists in the Neural Network Library
                return self[index] --// Return the index
            else --// If the index does not exist in the Neural Network Library
                error("Index '" .. index .. "' does not exist in the Neural Network Library") --// Throw an error
            end
        end
    }
); --/ You're probably thinking | Mr Lolegic why tf do you do this every time | Well it's just a design choice.

--// Neural Network Library Functions \\--  
function NN:feedForward(inputs) --// Feed Forward Function
    local activations = {}; --// Activations Table
    activations[1] = inputs; --// Set the first activation to the inputs
    for i = 1, #self.layers do --// Loop through the layers
        activations[i + 1] = {}; --// Set the next activation to a table
        for j = 1, #self.layers[i] do --// Loop through the neurons in the layer
            local sum = 0; --// Sum Variable
            for k = 1, #self.layers[i - 1] do --// Loop through the neurons in the previous layer
                sum = sum + activations[i][k] * self.weights[i - 1][k][j]; --// Add the sum to the weight * the activation
            end
            activations[i + 1][j] = self:activation(sum + self.biases[i - 1][j]); --// Set the next activation to the activation function of the sum + the bias
        end
    end
    return activations[#activations]; --// Return the last activation
end

function NN:backPropagate(inputs, targets) --// Back Propagate Function
    local activations = self:feedForward(inputs); --// Feed Forward the inputs
    local deltas = {}; --// Deltas Table
    for i = 1, #self.layers do --// Loop through the layers
        deltas[i] = {}; --// Set the delta to a table
    end
    for i = 1, #self.layers[#self.layers] do --// Loop through the neurons in the last layer
        deltas[#self.layers][i] = self:costDerivative(activations[#activations], targets)[i] * self:activationDerivative(activations[#activations][i]); --// Set the delta to the cost derivative * the activation derivative
    end
    for i = #self.layers - 1, 1, -1 do --// Loop through the layers in reverse
        for j = 1, #self.layers[i] do --// Loop through the neurons in the layer
            local sum = 0; --// Sum Variable
            for k = 1, #self.layers[i + 1] do --// Loop through the neurons in the next layer
                sum = sum + deltas[i + 1][k] * self.weights[i][j][k]; --// Add the sum to the delta * the weight
            end
            deltas[i][j] = sum * self:activationDerivative(activations[i + 1][j]); --// Set the delta to the sum * the activation derivative
        end
    end
    for i = 1, #self.layers - 1 do --// Loop through the layers
        for j = 1, #self.layers[i] do --// Loop through the neurons in the layer
            for k = 1, #self.layers[i + 1] do --// Loop through the neurons in the next layer
                self.weights[i][j][k] = self.weights[i][j][k] - self.learningRate * activations[i][j] * deltas[i + 1][k]; --// Set the weight to the weight - the learning rate * the activation * the delta
            end
            self.biases[i][j] = self.biases[i][j] - self.learningRate * deltas[i + 1][j]; --// Set the bias to the bias - the learning rate * the delta
        end
    end
end

function NN:train(inputs, targets) --// Train Function
    self:backPropagate(inputs, targets); --// Back Propagate the inputs and targets
    self.cost = self:costFunction(self:feedForward(inputs), targets); --// Set the cost to the cost function of the feed forward of the inputs and targets
end

function NN:activation(x) --// Activation Function
    if self.activationFunction == "sigmoid" then --// If the activation function is sigmoid
        return 1 / (1 + math.exp(-x)); --// Return the sigmoid of x
    elseif self.activationFunction == "tanh" then --// If the activation function is tanh
        return math.tanh(x); --// Return the tanh of x
    elseif self.activationFunction == "relu" then --// If the activation function is relu
        return math.max(0, x); --// Return the relu of x
    end
end

function NN:activationDerivative(x) --// Activation Derivative Function
    if self.activationFunction == "sigmoid" then --// If the activation function is sigmoid
        return self:activation(x) * (1 - self:activation(x)); --// Return the sigmoid of x * (1 - the sigmoid of x)
    elseif self.activationFunction == "tanh" then --// If the activation function is tanh
        return 1 - math.pow(math.tanh(x), 2); --// Return 1 - (the tanh of x ^ 2)
    elseif self.activationFunction == "relu" then --// If the activation function is relu
        return x > 0 and 1 or 0; --// Return x > 0 and 1 or 0
    end
end

function NN:costFunction(activations, targets) --// Cost Function
    if self.costFunction == "MSE" then --// If the cost function is MSE
        local sum = 0; --// Sum Variable
        for i = 1, #activations do --// Loop through the activations
            sum = sum + math.pow(activations[i] - targets[i], 2); --// Add the sum to (the activation - the target) ^ 2
        end
        return sum / #activations; --// Return the sum / the number of activations
    end
end

function NN:costDerivative(activations, targets) --// Cost Derivative Function
    if self.costFunction == "MSE" then --// If the cost function is MSE
        local sum = {}; --// Sum Table
        for i = 1, #activations do --// Loop through the activations
            sum[i] = 2 * (activations[i] - targets[i]) / #activations; --// Set the sum to 2 * (the activation - the target) / the number of activations
        end
        return sum; --// Return the sum
    end
end

--// Neural Network Test \\--

local nn = NN.new({2, 2, 1}, "sigmoid", "MSE", 0.1); --// Create a new neural network with 2 inputs, 2 hidden neurons, 1 output, sigmoid activation, MSE cost, and a learning rate of 0.1

local inputs = {0, 1}; --// Inputs Table
local targets = {1}; --// Targets Table

for i = 1, 10 do --// Loop 10 times
    nn:train(inputs, targets); --// Train the neural network with the inputs and targets
end

print(nn:feedForward(inputs)[1]); --// Print the output of the neural network with the inputs