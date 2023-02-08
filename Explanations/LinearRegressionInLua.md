# Building Linear Regression in Lua - Machine Learning


## Hypothesis function

Simple example of the `Hypothesis` function:
```lua
function Hypo(theta, x)
  return theta[1] + theta[2] * x
end
```

Lets start with the `Hypothesis` or `Prediction` function in linear regression. It takes in two parametes: `theta` and `x`. `Theta` is a vector of parameters that determines the line that we are trying to fit to the data, and `x` is a feature value.

The hypothesis function in linear regression is a linear equestion of the form `h(x) = theta[1] + theta[2] * x`, where `theta[1]` and `theta[2]` are the prameters that we want to learn, and `x` is the feature value.

## Cost function

Simple example of the `Cost` function:
```lua
function Cost(theta, x, y)
  local m = #x
  local sum = 0

  for i = 1, m do
    local error = h(theta, x[i]) - y[i]
    sum = sum + error ^ 2
  end

  return sum / (2 * m)
end
```

Now, lets moe on to the `Cost` function in linear regression. It takes in three parameters `theta`, `x`, and `y`. `Theta` is the same vector of parameters that we saw in the `Hypothesis` function, `x` is the feature values, and `y` is the corresponding output values of the training data.

The cost function measures how well the hypothesis fits the training data. I linear regression, the commonly used cost function is the mean squared error (MSE) between the predicted output and the actual output.

The `Cost` function implements this MSE cost function. It calculates the difference between the predicted output `Hypo(theta, x[i])` and the actual output `y[i]` for each training example, squares it, and adds it to a running sum. Finally, the sum is divided by `2 * m`, where `m` is the number of training examples, to get the mean squared error.

## Gradient Descent function

Simple example of the `Gradient Descent` function:
```lua
function gradientDescent(theta, x, y, alpha, num_iters)
  local m = #x

  for i = 1, num_iters do
    local delta = {0, 0}

    for j = 1, m do
      local error = h(theta, x[j]) - y[j]
      delta[1] = delta[1] + error
      delta[2] = delta[2] + error * x[j]
    end

    theta[1] = theta[1] - alpha / m * delta[1]
    theta[2] = theta[2] - alpha / m * delta[2]
  end

  return theta
end
```

The `gradientDescent` function performs gradient descent optimization to find the optimal values of `theta` that minimize the cost function `Cost`.

Gradient descent is a optimization algorithm that starts with an initial guess for the parameters `theta`, and iteratively updates the values of `theta` in the direction of the negative gradient of the cost function `Cost`. The gradient of `Cost` with respect to theta gives us the direction in which we should change theta to minimize the cost function.

The `gradientDescent` function implements this gradient descent optimization algorithm. It starts by initializing a delta vector with all elements set to 0. Then, for each training example `j`, it calculates the error error between the predicted output `h(theta, x[j])` and the actual output `y[j]`, and updates the elements of the delta vector by adding the error and the error times the feature value `x[j]`. Finally, it updates the values of theta by subtracting `alpha / m * delta[1]` from `theta[1]` and `alpha / m * delta[2]` from `theta[2]`, where `alpha` is the learning rate and `m` is the number of training examples.

This process is repeated `num_iters` times, until the values of `theta` converge to a minimum of the cost function. The final values of `theta` are returned by the `gradientDescent` function.

## Example use

Sample use function:
```lua
function run()
  local x = {1, 2, 3, 4, 5}
  local y = {2, 4, 4, 8, 6}
  local theta = {0, 0}
  local alpha = 0.01
  local num_iters = 1000
  theta = gradientDescent(theta, x, y, alpha, num_iters)
  print(string.format("theta0 = %f, theta1 = %f", theta[1], theta[2]))
end

run() --// Make sure you have all of the 
```

Made by: Mr Lolegic#0773

References: 
- https://www.analyticsvidhya.com/blog/2021/05/all-you-need-to-know-about-your-first-machine-learning-model-linear-regression/
- https://www.geeksforgeeks.org/ml-linear-regression/
- https://machinelearningmastery.com/linear-regression-for-machine-learning/
