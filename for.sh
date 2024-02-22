
# WORKDIR=/Users/wild/project/react/react-project
# WORKDIR=/Users/wild/project/react/react-project 这是目录路径案例

# echo $PROJECT


echo '开始---------------'

projectName=('a' 'b')

for i in ${projectName[*]}
do
echo $i
git checkout $i
git pull origin $i


done
echo "失败$i"