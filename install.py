import os
import subprocess

def create_virtualenv():
    """
    Creates a virtual environment .env if it does not exist.
    """
    if not os.path.exists('.env'):
        print("Creating virtual environment .env...")
        subprocess.run(['python3', '-m', 'venv', '.env'])

def install_dependencies():
    """
    Installs dependencies from the requirements.txt file.
    """
    print("Installing dependencies...")
    subprocess.run(['.env/bin/pip', 'install', '-r', 'requirements.txt'])

if __name__ == "__main__":
    create_virtualenv()
    install_dependencies()
    print("Installation completed.")
