import json 

def get_colors_dict() -> dict:
    with open("/home/lur/.cache/wal/colors.json", "r") as archive:
        colors_dict = json.loads(archive.read())
        return colors_dict

def get_path_wallpaper(colors_dict: dict) -> str:
    return colors_dict["wallpaper"]    



def add_path_zsh(path_image):
    file = open("/home/lur/.zshrc","r")
    content = file.readlines()

    for i in range(len(content)-1, -1, -1):
        if content[i].startswith("wal"):
            content[i] = "wal -n -i " + path_image
            break

    file = open("/home/lur/.zshrc","w")
    file.writelines(content)

def modify_polybar(colors_dict):
    file = open("/home/lur/.config/polybar/config.ini","r")
    content = file.readlines()

    color_high = colors_dict["colors"]["color1"]
    color_med = colors_dict["colors"]["color4"]
    color_low = colors_dict["colors"]["color6"]

    colors = colors_dict["special"]
    




    for i in range(len(content)):
        if content[i].startswith("bg"):
            content[i] = f"bg = {colors['background']}\n" 
        elif content[i].startswith("fg"):
            content[i] = f"fg = {colors['foreground']}\n" 
        elif content[i].startswith("mb"):
            content[i] = f"mb = {colors['background']}\n" 
        elif content[i].startswith("color_high"):
            content[i] = "color_high = " + color_high + "\n"
            print(content[i])
        elif content[i].startswith("color_med"):
            content[i] = "color_med = " + color_med + "\n"
            print(content[i])

        elif content[i].startswith("color_low"):
            content[i] = "color_low = " + color_low + "\n"
            print(content[i])

        


    file = open("/home/lur/.config/polybar/config.ini","w")
    file.writelines(content)


def main():
    colors_dict = get_colors_dict()
    path_wallpaper = get_path_wallpaper(colors_dict)
    add_path_zsh(path_wallpaper)
    modify_polybar(colors_dict)
main()