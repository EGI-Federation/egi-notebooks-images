import mbtr.losses as losses
from ._splash import splash

LOSS_MAP = {'mse': losses.MSE,
            'mse_custom':losses.MSE_custom,
            'time_smoother': losses.TimeSmoother,
            'latent_variable': losses.LatentVariable,
            'linear_regression': losses.LinRegLoss,
            'fourier': losses.FourierLoss,
            'quantile': losses.QuantileLoss,
            'quadratic_quantile': losses.QuadraticQuantileLoss}


