import torch
from models.main_model import MainModel
from utils.training import visualize

# Example usage for visualization
# Make sure to adjust the paths and load your data accordingly

device = torch.device("cuda" if torch.cuda.is_available() else "cpu")

model = MainModel()
model.load_state_dict(torch.load("path_to_your_trained_model.pth", map_location=device))

data = next(iter(val_dl))  # Load a batch of validation data
visualize(model, data, save=True)
