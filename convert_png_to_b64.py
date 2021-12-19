import base64
with open("de2.png", "rb") as img_file:
    my_string = base64.b64encode(img_file.read())
    print(my_string)
