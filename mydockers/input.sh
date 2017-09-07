source ~/Documents/py3/bin/activate 
cd /Users/harry/PycharmProjects/video_mgt
#python Program.py -u https://www.youtube.com/watch?v=lqE2uYnlLGQ -o "/Users/harry/Movies/VideoManager" -p False
#python Program.py -u https://www.youtube.com/watch?v=BLRalrUHNIg -o "/Users/harry/Movies/VideoManager" -p False
#python Program.py -u https://www.youtube.com/watch?v=mU_A-EgB38s -o "/Users/harry/Movies/VideoManager" -p False
python Program.py -u "https://youtu.be/kzt3-FHdAeM"  -o "/home/ubuntu/output" -p False
#aws s3 --recursive mv "s3://videos.wode.ai/MIT_2016 Introduction to Computational Thinking and Data Science" "s3://videos.wode.ai/DataScience_MIT"