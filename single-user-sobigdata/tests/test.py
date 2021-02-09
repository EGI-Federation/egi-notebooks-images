import pyspark
import pyclustering
import pydotplus
import simpletransformers
import rtree
import geopandas
import nltk
import torch
import torchtext
import cv2
import selenium
import tweepy
import requests
import transformers
from keras.models import Sequential
import tensorflow
import fim

import tensorflow as tf

mnist = tf.keras.datasets.mnist
(x_train, y_train), (x_test, y_test) = mnist.load_data()
x_train, x_test = x_train / 255.0, x_test / 255.0

model = tf.keras.models.Sequential([
  tf.keras.layers.Flatten(input_shape=(28, 28)),
  tf.keras.layers.Dense(128, activation='relu'),
  tf.keras.layers.Dropout(0.2),
  tf.keras.layers.Dense(10)
])

predictions = model(x_train[:1]).numpy()
predictions
loss_fn = tf.keras.losses.SparseCategoricalCrossentropy(from_logits=True)


