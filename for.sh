
# WORKDIR=/Users/wild/project/react/react-project
# WORKDIR=/Users/wild/project/react/react-project 这是目录路径案例

# echo $PROJECT
master="main"

echo '开始---------------'

projectName=('a' 'b')

for i in ${projectName[*]}
do
echo $i
git checkout $i
git pull origin $i
git merge --no-ff $master


echo "运行完成 $i"


done
echo "执行结束"