# Intro to Python

## Start today's class

Sign in to a Google account, then click the button for the class. The notebook
opens in Google Colab, ready to edit. Click a cell and press Shift+Enter to
run it.

| Class | Open |
| --- | --- |
| 1. Notebooks | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/1_Notebooks.ipynb) |
| 2. Statements | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/2_Statements.ipynb) |
| 3. Composite Types | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/3_Composite_Types.ipynb) |
| 4. Control Structures | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/4_Control_Structures.ipynb) |
| 5. Loops | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/5_Loops.ipynb) |
| 6. Libraries and Graphics | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/6_Libraries_and_Graphics.ipynb) |
| 7. Functions | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/7_Functions.ipynb) |
| 8. Bringing it all Together | [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/bmabsout/BUA-Intro-Python/blob/main/bua_1/8_Bringing_it_all_Together.ipynb) |

Before editing, choose **File > Save a copy in Drive**. Work in that copy.
Colab does not automatically save changes back to GitHub. Use the same Drive
copy when you return to a class.

NumPy and Matplotlib are already available. Turtle graphics do not work in
Colab, so the drawing exercises in classes 6–8 will not display.

## Run Jupyter on your own computer

This is optional. It works the same way on Windows, macOS, and Linux, and it
does not save to GitHub automatically.

1. Install [Git](https://git-scm.com/install/) and
   [uv](https://docs.astral.sh/uv/getting-started/installation/).
   On macOS or Linux:

   ```sh
   curl -LsSf https://astral.sh/uv/install.sh | sh
   ```

   On Windows PowerShell:

   ```powershell
   powershell -ExecutionPolicy ByPass -c "irm https://astral.sh/uv/install.ps1 | iex"
   ```

   Close and reopen the terminal if `uv` is not found.

2. Clone the repository and start Jupyter. On macOS or Linux:

   ```sh
   git clone https://github.com/bmabsout/BUA-Intro-Python.git
   cd BUA-Intro-Python
   sh scripts/start-jupyter.sh
   ```

   On Windows PowerShell:

   ```powershell
   git clone https://github.com/bmabsout/BUA-Intro-Python.git
   cd BUA-Intro-Python
   powershell -ExecutionPolicy Bypass -File .\scripts\start-jupyter.ps1
   ```

Choose a notebook in `bua_1`. Stop Jupyter with Ctrl+C.
