cd ~

#download the cs231n assignments.
mkdir notebooks
cd notebooks
mkdir cs231n
cd cs231n
wget http://cs231n.stanford.edu/assignments/2017/spring1617_assignment1.zip
wget http://cs231n.stanford.edu/assignments/2017/spring1617_assignment3_v3.zip
wget http://cs231n.stanford.edu/assignments/2017/spring1617_assignment2.zip

unzip spring1617_assignment1.zip 
unzip spring1617_assignment2.zip
unzip spring1617_assignment3_v3.zip
rm -f *.zip

cd ~/notebooks/cs231n/assignment1/cs231n/datasets
sh get_datasets.sh

cd ~/notebooks/cs231n/assignment2/cs231n/datasets
sh get_datasets.sh



#Download the course of fast.ai
cd ~/notebooks
mkdir fast.ai
cd fast.ai
git clone https://github.com/fastai/courses.git

#download the cs231n assignments.
cd ~/notebooks
mkdir cs224d
cd cs224d
wget http://web.stanford.edu/class/cs224n/assignment1/assignment1.zip
wget http://web.stanford.edu/class/cs224n/assignment2/assignment2.zip
wget http://web.stanford.edu/class/cs224n/assignment3/assignment3.zip
wget http://web.stanford.edu/class/cs224n/assignment4/assignment4.zip

unzip assignment1.zip 
unzip assignment2.zip
unzip assignment3.zip
unzip assignment4.zip
rm -f *.zip


cd ~/notebooks
git clone https://github.com/aymericdamien/TensorFlow-Examples
