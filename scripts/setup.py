# Creates a symbolic link for files in the ".files" and ".dirs" programs

import ctypes
import os
import sys

# checks if the script is running as admin, exits if not
if not ctypes.windll.shell32.IsUserAnAdmin():
    sys.exit("This script requires to run as administrator")

print('Creating a symbolic link for files in the ".files" and ".dirs" programs')


HOME = os.path.expanduser("~")
dot_path_files = HOME + "\.dotfiles\.files"
dot_path_dirs = HOME + "\.dotfiles\.dirs"

dot_files = os.listdir(dot_path_files)
dot_dirs = os.listdir(dot_path_dirs)


def files_symlink() -> None:
    """Creates a symlink in ~ for all files in .files dir
    """
    for file in dot_files:
        src = dot_path_files + "\\" + file
        dst = HOME + "\\" + file

        try:
            os.symlink(src, dst)
        except FileExistsError:
            print(f"[SKIPPED] {src} -> {dst}")
            continue

        print(f"{src} -> {dst}")


def dirs_symlink() -> None:
    """Creates a symlink in ~ for all directories in .dirs dir
    """
    for diry in dot_dirs:
        src = dot_path_dirs + "\\" + diry
        dst = HOME + "\\" + diry

        print(f"{src} -> {dst}")

        try:
            os.symlink(src, dst, True)
        except FileExistsError:
            continue


def main():
    files_symlink()
    dirs_symlink()


if __name__ == "__main__":
    main()
