import numpy as np

def sigmoid(x):
    return 1 / (1 + np.exp(-x))

def softplus(x):
    return np.log10(1 + np.exp(x))

def diff_softplus(x):
    return sigmoid(x)

def forward(pixel, wLeft_mean, wLeft_var, bLeft_mean, bLeft_var, wRight, bRight, in_layer, len_layers, aLeft_mean, aLeft_var, zLeft_mean, zLeft_var, aRight, zRight):
    in_layer[0] = pixel
    for layer in range(len_layers // 2):
        zLeft_mean[layer + 1] = np.matmul(wLeft_mean[layer + 1], in_layer[layer]) + bLeft_mean[layer + 1]
        zLeft_var[layer + 1] = np.matmul(wLeft_var[layer + 1], in_layer[layer]) + bLeft_var[layer + 1]

        aLeft_mean[layer + 1] = zLeft_mean[layer + 1]
        aLeft_var[layer + 1] = softplus(zLeft_var[layer + 1])

        eps = np.random.normal(size=zLeft_mean[layer + 1].shape)
        in_layer[layer + 1] = aLeft_mean[layer + 1] + np.sqrt(aLeft_var[layer + 1]) * eps

    for layer in range(len_layers // 2, len_layers - 1):
        zRight[layer + 1] = np.matmul(wRight[layer + 1], in_layer[layer]) + bRight[layer + 1]
        aRight[layer + 1] = sigmoid(zRight[layer + 1])

        in_layer[layer + 1] = aRight[layer + 1]

def backward(pixel, wLeft_mean, wLeft_var, bLeft_mean, bLeft_var, wRight, bRight, in_layer, len_layers, aLeft_mean, aLeft_var, zLeft_mean, zLeft_var, aRight, zRight, gradients, loss):
    dLoss = loss  # Assume loss is a gradient of the final layer output wrt loss

    # Backpropagation for the decoder (Right side)
    for layer in reversed(range(len_layers // 2, len_layers - 1)):
        dz = dLoss * (aRight[layer + 1] * (1 - aRight[layer + 1]))  # Derivative of sigmoid
        gradients['wRight'][layer + 1] = np.matmul(dz, in_layer[layer].T)
        gradients['bRight'][layer + 1] = dz
        dLoss = np.matmul(wRight[layer + 1].T, dz)

    # Backpropagation for the encoder (Left side)
    for layer in reversed(range(len_layers // 2)):
        dz_mean = dLoss
        dz_var = dLoss * diff_softplus(zLeft_var[layer + 1])

        gradients['wLeft_mean'][layer + 1] = np.matmul(dz_mean, in_layer[layer].T)
        gradients['bLeft_mean'][layer + 1] = dz_mean

        gradients['wLeft_var'][layer + 1] = np.matmul(dz_var, in_layer[layer].T)
        gradients['bLeft_var'][layer + 1] = dz_var

        dLoss = np.matmul(wLeft_mean[layer + 1].T, dz_mean) + np.matmul(wLeft_var[layer + 1].T, dz_var)

# Example initialization of gradients dictionary
def initialize_gradients(len_layers, layer):
    gradients = {
        'wLeft_mean': [np.zeros((layer[i + 1], layer[i])) if i + 1 < len_layers // 2 else None for i in range(len_layers)],
        'bLeft_mean': [np.zeros((layer[i + 1], 1)) if i + 1 < len_layers // 2 else None for i in range(len_layers)],
        'wLeft_var': [np.zeros((layer[i + 1], layer[i])) if i + 1 < len_layers // 2 else None for i in range(len_layers)],
        'bLeft_var': [np.zeros((layer[i + 1], 1)) if i + 1 < len_layers // 2 else None for i in range(len_layers)],
        'wRight': [np.zeros((layer[i + 1], layer[i])) if i >= len_layers // 2 else None for i in range(len_layers)],
        'bRight': [np.zeros((layer[i + 1], 1)) if i >= len_layers // 2 else None for i in range(len_layers)],
    }
    return gradients
