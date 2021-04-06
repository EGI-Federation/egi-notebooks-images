import cv2
import fim
import geopandas
import nltk
import pyclustering
import pydotplus
import pyspark
import requests
import rtree
import selenium
import simpletransformers
import tensorflow
import tensorflow as tf
import torch
import torchtext
import transformers
import tweepy
from keras.models import Sequential

mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

model = tf.keras.models.Sequential(
    [
        tf.keras.layers.Flatten(input_shape=(28, 28)),
        tf.keras.layers.Dense(128, activation="relu"),
        tf.keras.layers.Dropout(0.2),
        tf.keras.layers.Dense(10),
    ]
)

predictions = model(x_train[:1]).numpy()
predictions
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)
