# Creates a symbolic link for files in the ".files" and ".dirs" programs

import ctypes

admin = (
    ctypes.windll.shell32.IsUserAnAdmin()
)  # checks if the script is running as admin

if not admin:
    print("This script requires to run as administrator")
    exit()

print('Creating a symbolic link for files in the ".files" and ".dirs" programs')

import os

HOME = os.path.expanduser("~")
dot_path_files = HOME + "\.dotfiles\.files"
dot_path_dirs = HOME + "\.dotfiles\.dirs"

dot_files = os.listdir(dot_path_files)
dot_dirs = os.listdir(dot_path_dirs)

for file in dot_files:
    og_path = dot_path_files + "\\" + file
    link_path = HOME + "\\" + file

    command = f"mklink {link_path} {og_path}"
    print(command)
    os.system(command)


for directory in dot_dirs:
    og_path = dot_path_dirs + "\\" + directory
    link_path = HOME + "\\" + directory

    command = f"mklink /d {link_path} {og_path}"
    print(command)
    os.system(command)
