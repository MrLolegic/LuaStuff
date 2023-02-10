--// Made by Mr. Lolegic
--// Simple feed-forward neural network in pure lua

--// Define the activation function
function sigmoid(x)
    return 1 / (1 + math.exp(-x))
end

--// Define the derivative of the activation function
function sigmoid_prime(x)
    return x * (1 - x)
end

--// Define the network structure
inputs = 2
hidden_layers = 1
hidden_units = 2
outputs = 1
hidden = {}

--// Initialize the weights
weights = {}
weights[1] = {}
weights[1][1] = math.random()
weights[1][2] = math.random()
weights[2] = {}
weights[2][1] = {}
weights[2][1][1] = math.random()
weights[2][1][2] = math.random()
weights[2][2] = {}
weights[2][2][1] = math.random()
weights[2][2][2] = math.random()
weights[3] = {}
weights[3][1] = math.random()
weights[3][2] = math.random()

--// Define the forward pass
function forward(inputs)
	hidden[1] = {}
    hidden[1][1] = sigmoid(inputs[1] * weights[1][1] + inputs[2] * weights[1][2])
    hidden[1][2] = sigmoid(inputs[1] * weights[1][1] + inputs[2] * weights[1][2])
    hidden[2] = {}
    hidden[2][1] = sigmoid(hidden[1][1] * weights[2][1][1] + hidden[1][2] * weights[2][1][2])
    hidden[2][2] = sigmoid(hidden[1][1] * weights[2][2][1] + hidden[1][2] * weights[2][2][2])

	local output = sigmoid(hidden[2][1] * weights[3][1] + hidden[2][2] * weights[3][2])

	return output
end

--// Define the loss function
function loss(prediction, target)
    return 0.5 * (prediction - target)^2
end

--// Define the learning rate
lr = 0.1

--// Define the backward pass (using gradient descent)
function backward(inputs, prediction, target)
  local d_prediction = prediction - target
  local d_output = d_prediction * sigmoid_prime(prediction)

  local d_hidden = {}
  d_hidden[2] = {}
  d_hidden[2][1] = d_output * weights[3][1] * sigmoid_prime(hidden[2][1])
  d_hidden[2][2] = d_output * weights[3][2] * sigmoid_prime(hidden[2][2])

  d_hidden[1] = {}
  d_hidden[1][1] = d_hidden[2][1] * weights[2][1][1] * sigmoid_prime(hidden[1][1])
  d_hidden[1][2] = d_hidden[2][2] * weights[2][2][2] * sigmoid_prime(hidden[1][2])

  weights[3][1] = weights[3][1] - lr * d_output * hidden[2][1]
  weights[3][2] = weights[3][2] - lr * d_output * hidden[2][2]

  weights[2][1][1] = weights[2][1][1] - lr * d_hidden[2][1] * hidden[1][1]
  weights[2][1][2] = weights[2][1][2] - lr * d_hidden[2][1] * hidden[1][2]
  weights[2][2][1] = weights[2][2][1] - lr * d_hidden[2][2] * hidden[1][1]
  weights[2][2][2] = weights[2][2][2] - lr * d_hidden[2][2] * hidden[1][2]

  weights[1][1] = weights[1][1] - lr * d_hidden[1][1] * inputs[1]
  weights[1][2] = weights[1][2] - lr * d_hidden[1][2] * inputs[2]
end

--// Train the network on a single example
function train(inputs, target)
  local prediction = forward(inputs)
  backward(inputs, prediction, target)
end

--// Train the network on multiple examples
function train_on_batch(inputs, targets)
  for i = 1, #inputs do
    train(inputs[i], targets[i])
  end
end

inputs = {0.5, 0.1}
target = 0.4

for i = 1, 1000 do
  train(inputs, target)
end

--// Make predictions
prediction = forward(inputs)

print("Prediction: " .. prediction)
