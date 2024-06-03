import os
import glob
import numpy as np
from PIL import Image
from pathlib import Path
from tqdm.notebook import tqdm
import matplotlib.pyplot as plt
from skimage.color import rgb2lab, lab2rgb
import torch
from torch import nn, optim
from torchvision import transforms
from torch.utils.data import Dataset, DataLoader
from models.main_model import MainModel
from utils.dataset import make_dataloaders
from utils.training import train_model

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

# Path for your dataset
paths = glob.glob("datasets/coco/*.jpg")
np.random.seed(123)
paths_subset = np.random.choice(paths, 10_000, replace=False)
rand_idxs = np.random.permutation(10_000)
train_idxs = rand_idxs[:8000]
val_idxs = rand_idxs[8000:]
train_paths = paths_subset[train_idxs]
val_paths = paths_subset[val_idxs]
print(len(train_paths), len(val_paths))

SIZE = 256
train_dl = make_dataloaders(paths=train_paths, split='train')
val_dl = make_dataloaders(paths=val_paths, split='val')

model = MainModel()
train_model(model, train_dl, val_dl, epochs=100)
