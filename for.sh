
WORKDIR=/e/mx/front/front-end-project-react
# echo $PROJECT
master="master"

echo '开始---------------'

projectName=('oem-nengrui' 'oem-yiyao' 'oem-aisino' 'oem-huoyujuzhen' 'oem-ifacebox' 'oem-skieer' 'oem-upimc' 'oem-holyscape' 'oem-pioneerdata' 'oem-yijing')

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

PROJECT=$i

echo $PROJECT
echo $WORKDIR


if [ ! $WORKDIR ]; then
  echo '请配置目录路径 WORKDIR'
  exit;
fi


# 获取工程版本号
VERSION=$(cat $WORKDIR/projects/$PROJECT/package.json | grep "version" | sed 's/"version": //g' | sed 's/"//g' | sed 's/ //g' | sed 's/,//g' | sed 's/\r//g')
# 获取package.name
PACKNAME=$(cat $WORKDIR/projects/$PROJECT/package.json | grep "name" | sed 's/"name": //g' | sed 's/"//g' | sed 's/ //g' | sed 's/,//g' | sed 's/\r//g')

# 清理dist目录
echo "清理dist目录 $WORKDIR/dist/$PACKNAME"
rm -rf $WORKDIR/dist/$PACKNAME
rm -rf $WORKDIR/dist/reactLibs

# 打印变量
echo "打包目录: $PROJECT"
echo "版本号: $VERSION"
echo "packageName: $PACKNAME"

echo "npm run build:prod reactLibs $PROJECT"
npm run build:prod reactLibs $PROJECT

distPath=$WORKDIR/dist/$PACKNAME/$VERSION

echo "dist目录: $distPath"

sleep 2

if [ ! -d "$distPath" ]; then
  echo '打包可能存在失败 请检查日志'
  exit;
fi

isMkdir=false

if [ $PROJECT != $PACKNAME ] && [ ! -d "$WORKDIR/projects/$PACKNAME" ]; then
  mkdir $WORKDIR/projects/$PACKNAME
  cp $WORKDIR/projects/$PROJECT/package.json $WORKDIR/projects/$PACKNAME/
  isMkdir=true
fi

echo "推送cdn资源 reactLibs $PACKNAME"
npm run push:cdn:prod reactLibs $PACKNAME

node ./docker/pushHtml.js $PACKNAME

if [ $isMkdir ]; then
  rm -rf $WORKDIR/dist/.$PACKNAME 
  mv $WORKDIR/projects/$PACKNAME $WORKDIR/dist/.$PACKNAME 
fi

echo "运行完成 $i"


done
echo "---- 结束 END ----"