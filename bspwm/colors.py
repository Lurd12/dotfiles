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
            content[i] = "wal -n -q -i " + path_image
            break

    file = open("/home/lur/.zshrc","w")
    file.writelines(content)

def modify_polybar(colors_dict):
    file = open("/home/lur/.config/polybar/config.ini","r")
    content = file.readlines()

    color_high = colors_dict["colors"]["color1"]
    color_med = colors_dict["colors"]["color4"]
    color_low = colors_dict["colors"]["color5"]

    colors = colors_dict["special"]

    for i in range(len(content)):
        if content[i].startswith("bg-alt"):
            content[i] = f"bg-alt = {colors['background']}\n" 
        elif content[i].startswith("bg_2"):
            content[i] = f"bg_2 = {colors['foreground']}\n" 
        elif content[i].startswith("mb"):
            content[i] = f"mb = {colors['background']}\n" 
        elif content[i].startswith("icon_color"):
            content[i] = "icon_color = " + color_high + "\n"
        elif content[i].startswith("icon_strong"):
            content[i] = "icon_strong = " + color_low + "\n"
        elif content[i].startswith("trans"):
            break

    file = open("/home/lur/.config/polybar/config.ini","w")
    file.writelines(content)

def modify_rofy(colors_dict):
    file = open("/home/lur/.config/rofi/config.rasi","r")
    colors = colors_dict["special"]
    color_high = colors_dict["colors"]["color1"]
    color_med = colors_dict["colors"]["color4"]
    color_low = colors_dict["colors"]["color5"]
    content=file.readlines()

    for i in range(len(content)):
        if content[i].startswith("\tbackground-color"):
            content[i] = f"\tbackground-color: {colors['background']};\n"
        elif content[i].startswith("\tforeground"):
            content[i] = f"\tforeground: {colors['foreground']};\n"
        elif content[i].startswith("\tactive-background"):
            content[i] = f"\tactive-background: {color_med};\n"

    file = open("/home/lur/.config/rofi/config.rasi","w")
    file.writelines(content)





def main():
    colors_dict = get_colors_dict()
    path_wallpaper = get_path_wallpaper(colors_dict)
    add_path_zsh(path_wallpaper)
    modify_polybar(colors_dict)
    modify_rofy(colors_dict)
main()
