from PIL import Image
import os

def convert_jpg_to_webp(input_path):
    # Open the JPG image
    with Image.open(input_path) as img:
        # Get the directory and filename
        directory, filename = os.path.split(input_path)
        # Generate the output file path with the same name but WebP extension
        output_path = os.path.join(directory, os.path.splitext(filename)[0] + ".webp")
        # Convert and save as WebP format
        img.save(output_path, 'WEBP')
        print(filename, "to webp")
    return output_path

def convert_images_in_folder(folder_path):
    # Get a list of all files in the folder
    files = os.listdir(folder_path)
    # Filter out only JPG files
    jpg_files = [file for file in files if file.lower().endswith('.png')]
    # Convert each JPG file to WebP
    for jpg_file in jpg_files:
        jpg_path = os.path.join(folder_path, jpg_file)
        convert_jpg_to_webp(jpg_path)

def delete_jpg_files(folder_path):
    # Get a list of all files in the folder
    files = os.listdir(folder_path)
    # Filter out only JPG files
    jpg_files = [file for file in files if file.lower().endswith('.png')]
    # Delete each JPG file
    for jpg_file in jpg_files:
        jpg_path = os.path.join(folder_path, jpg_file)
        os.remove(jpg_path)

# Example usage:
folder_path = '/Users/azballkung/Desktop/MyFirstFlutter/my_project/assets/Blue_Archive/characters/memorial_lobby_icons/'

convert_images_in_folder(folder_path)
print('Conversion complete for all images in the folder.')


delete_jpg_files(folder_path)
print('Deletion complete for all JPG files in the folder.')