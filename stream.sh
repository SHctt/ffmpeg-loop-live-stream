#!/bin/bash
set -e
#=================================================================#
#   System Required: docker image                                 #
#   Description: FFmpeg Stream Media Server on docker             #
#   Author: steve                                                 #
#=================================================================#

#读取推流地址
rtmp=$RTMP_ADD
if [[ $rtmp =~ "rtmp://" ]];then
  echo "推流地址格式正确，当前推流地址为:$rtmp"
else
  echo "必须为容器设置正确格式的推流地址环境变量RTMP_ADD."
  exit
fi

#设置推流文件夹
folder=$VIDEO_FOLDER
if [ -z "$folder" ];then
  folder=/ffmpeg/video
  echo "未指定视频文件目录,将默认对 $folder 文件夹中的mp4文件推流"
else
  echo "将对 $VIDEO_FOLDER 文件夹中的mp4文件推流"
fi

# 开始循环推流
while true
do
  cd $folder
  for video in $(ls *.mp4)
  do
  ffmpeg -re -i "$video" -c:v copy -c:a aac -b:a 192k -strict -2 -f flv ${rtmp}
  done
done

exec "$@"