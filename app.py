import gradio as gr
import torch
from models.main_model import MainModel
from utils.training import lab_to_rgb
from torchvision import transforms
from PIL import Image
import numpy as np
import argparse

# Load your model
device = torch.device("cuda" if torch.cuda.is_available() else "cpu")
model = MainModel()
model.load_state_dict(torch.load("path_to_your_trained_model.pth", map_location=device))

# Define the function to handle the image colorization
def colorize_image(img, model_choice):
    model_path = model_paths[model_choice]
    model = MainModel()
    model.load_state_dict(torch.load(model_path, map_location=device))
    
    model.net_G.eval()
    transform = transforms.Compose([
        transforms.Resize((256, 256)),
        transforms.ToTensor(),
        transforms.Normalize((0.5,), (0.5,))
    ])

    img = Image.fromarray(img).convert("RGB")
    img = transform(img).unsqueeze(0).to(device)
    
    with torch.no_grad():
        L = img[:, 0:1, :, :]
        fake_color = model.net_G(L)
    fake_color = fake_color.detach()
    L = L.detach()
    
    fake_imgs = lab_to_rgb(L, fake_color)
    return fake_imgs[0]

# Dictionary to map model choices to their respective paths
model_paths = {
    "Pre-trained Model 1": "path_to_model_1.pth",
    "Pre-trained Model 2": "path_to_model_2.pth"
}

# Create the Gradio interface
iface = gr.Interface(
    fn=colorize_image,
    inputs=[
        gr.inputs.Image(shape=(256, 256)),
        gr.inputs.Dropdown(choices=list(model_paths.keys()), label="Select Model")
    ],
    outputs="image",
    title="Image Colorizer",
    description="Upload a grayscale image to colorize it using a pre-trained model."
)

if __name__ == "__main__":
    parser = argparse.ArgumentParser()
    parser.add_argument("--port", type=int, default=7860, help="Port to run the Gradio app on")
    parser.add_argument("--server_name", type=str, default="localhost", help="Server name to run the Gradio app on")
    args = parser.parse_args()
    iface.launch(server_name=args.server_name, port=args.port)
