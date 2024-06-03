
# Colorization Project

This project is an image colorization application using deep learning models. The application utilizes Gradio for the user interface and supports running on both Windows and macOS/Linux environments.

## Table of Contents

- [Setup Instructions](#setup-instructions)
  - [Windows](#windows)
  - [macOS and Linux](#macos-and-linux)
- [Running the Application](#running-the-application)
  - [Windows](#windows)
  - [macOS and Linux](#macos-and-linux)
- [Usage](#usage)
- [Project Structure](#project-structure)
- [Contributing](#contributing)
- [License](#license)

## Setup Instructions

### Windows

1. Clone the repository:
   ```sh
   git clone https://github.com/AcTePuKc/colorization_project.git
   cd colorization_project
   ```

2. Run `setup.bat` to set up the environment and start the application:
   ```sh
   setup.bat
   ```

### macOS and Linux

1. Clone the repository:
   ```sh
   git clone https://github.com/AcTePuKc/colorization_project.git
   cd colorization_project
   ```

2. Make `setup.sh` executable and run it:
   ```sh
   chmod +x setup.sh
   ./setup.sh
   ```

## Running the Application

After the initial setup, you can run the application using the same setup scripts with the `--skip-setup` option to avoid redundant setup processes.

### Windows

To run the application after the initial setup, use:
   ```sh
   setup.bat --skip-setup
   ```

### macOS and Linux

To run the application after the initial setup, use:
   ```sh
   ./setup.sh --skip-setup
   ```

## Usage

Once the application is running, you can access the Gradio interface on `http://localhost:7860`. Upload a grayscale image to colorize it using the pre-trained model.

## Project Structure

```
colorization_project/
│
├── datasets/
│   └── Your_IMAGES_HERE.txt (Placeholder text file for image dataset)
│
├── models/
│   ├── __init__.py
│   ├── unet.py
│   ├── discriminator.py
│   └── main_model.py
│
├── utils/
│   ├── __init__.py
│   ├── dataset.py
│   ├── loss.py
│   └── training.py
│
├── environment.yml
├── setup.bat
├── run.bat
├── setup.sh
├── run.sh
├── app.py
├── train.py
├── visualize.py
└── README.md
```

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch`).
3. Make your changes.
4. Commit your changes (`git commit -m 'Add some feature'`).
5. Push to the branch (`git push origin feature-branch`).
6. Open a pull request.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
