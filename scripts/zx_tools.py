import requests
from tqdm import tqdm
from zipfile import ZipFile
import pathlib


def download_and_extract(*, url: str, dest: str, name: str):
    try:
        print(f"Downloading {name}, please be patient...")
        r = requests.get(url, stream=True)
        print(f"Connection opened successfully to {url}")
        exc_size = int(r.headers.get("Content-Length", 0))
        block_size = 10

        with tqdm(total=exc_size, unit="B", unit_scale=True) as progress_bar:
            with open(dest, "wb") as file:
                for data in r.iter_content(block_size):
                    progress_bar.update(len(data))
                    file.write(data)
        print(f"{name} successfully finished download.")
    except requests.RequestException as err:
        print(f"Error downloading {name}: \n{err.strerror}")
        return


def unzip_file(*, zip_path, file_path: str):
    with ZipFile(zip_path, "r") as z:
        z.extractall(path=file_path)


def update_zshrc():
    p = pathlib.Path(__file__).parent.parent.resolve()
    contents = "# Z88dk path & environment\n"
    contents += "export PATH=${PATH}:"
    contents += f"{p}/apps/z88dk/bin\n"
    contents += "export ZCCCFG="
    contents += f"{p}/apps/z88dk/lib/config\n"
    print(f"1. Copy & paste the following to your ~/.zshrc file:\n\n{contents}")


if __name__ == "__main__":
    download_and_extract(
        url="https://github.com/chernandezba/zesarux/releases/download/ZEsarUX-11.0/ZEsarUX_macos-11.0.dmg",
        dest="../apps/ZEsarUX.dmg",
        name="ZEsarUX",
    )
    download_and_extract(
        url="https://sourceforge.net/projects/fuse-for-macosx/files/latest/download",
        dest="../apps/Fuse.dmg",
        name="Fuse",
    )
    download_and_extract(
        url="https://github.com/z88dk/z88dk/releases/download/v2.3/z88dk-osx-2.3.zip",
        dest="../apps/z88dk.zip",
        name="z88dk",
    )
    print("Unzipping z88dk.zip...")
    unzip_file(zip_path="../apps/z88dk.zip", file_path="../apps")
    print("Installation instructions:")
    print("\n------------------------------------------\n")
    update_zshrc()
    print("2. Open new a finder window in this project & navigate to the apps directory\n"
          "& click on ZEsarUX.dmg to install the ZEsarUX emulator.")
