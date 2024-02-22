
# WORKDIR=/Users/wild/project/react/react-project
# WORKDIR=/Users/wild/project/react/react-project 这是目录路径案例

# echo $PROJECT
master="main"

echo '开始---------------'

projectName=('a' 'b' 'c')

for i in ${projectName[*]}
do
echo $i
git checkout $i
git pull origin $i
git merge --no-ff $master
 sed -i '8d' package.json
 sed -i '6d' package.json
 sed -i '5d' package.json
 sed -i '4d' package.json
 sed -i '2d' package.json
git add .
git commit -m 'fix:修复冲突'
git push origin $i

echo "运行完成 $i"


done
echo "执行结束"