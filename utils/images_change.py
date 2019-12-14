import os
import cv2
import glob
import mysql.connector

folder_name="/Users/saif/Code/ACLImages/Categories/Player-images/*/"
group_Ids = {
"JAR 1":14,"JAR 2":13,"JAR Vice Captains":1,"JBT 1":12
,"JBT 2":11,"JBW 1":10,"JBW 2":9,"SAR 1":8,"SAR 2":7,
"SBT 1":6,"SBT 2":5,"SBT 3":4,"SBT 4":3,"SBW 1":2
}
mydb = mysql.connector.connect(
  host="localhost",
  user="root",
  passwd="",
  database="ACL17"
)


global_count = 0
folders_list = [folder.split("/")[-2].strip() for folder in glob.glob(folder_name)]
old_folders_list = [folder_name[:-3] + "/" + folder for folder in folders_list]

def input_into_database(player_name,group_name):
    f_name = player_name.split(" ")[0]
    l_name = player_name.split(" ")[-1]
    l_name = l_name.split(".")[0]
    price = 0
    if(group_name[0]=="J"):
        database_path = "images/players/Juniors/"
    else:
        database_path = "images/players/Seniors/"
    database_path += group_name+"/"
    mycursor = mydb.cursor()
    sql_query = "INSERT INTO Players(group_id, player_fname, player_lname, player_image, team_id, price) VALUES (%s, %s, %s, %s, %s, %s)"
    #sql = "INSERT INTO customers (name, address) VALUES (%s, %s)"
    val = (group_Ids[group_name],f_name, l_name, database_path+player_name, 0, 0)
    mycursor.execute(sql_query, val)
    mydb.commit()


for folder in old_folders_list:
    images_list = glob.glob(folder + "/*.*")
    images_by_ascending = [image.split("/")[-1] for image in images_list]
    group_name = folder.split("/")[7]
    print(group_name)
    #images_by_ascending.sort()
    #os.mkdir(folder + " - cropped")
    for i, image in enumerate(images_by_ascending):
        img = cv2.imread(folder + "/" + image)
        # img = cv2.resize(img, (512, 512))
        path = folder + " - cropped" + "/" + image
        cv2.imwrite(path, img)
        input_into_database(image,group_name)