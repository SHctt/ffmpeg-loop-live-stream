# 直播间无限循环推流

使用 docker 作为守护进程，实现 ffmpeg 无限循环推流

## 创建 docker image

```
docker build -t live_stream .
```

## 开始推流

```
docker run -it --rm -e VIDEO_FOLDER=/ffmpeg/video -e RTMP_ADD={your-RTMP-address} --mount type=bind,src="$(pwd)/video",target=/ffmpeg/video live_stream
```

## 注意事项

- 启动容器必添加好正确格式的推流地址环境变量，使用`-e RTMP_ADD={your-RTMP-address}`

- 在不设定推流目录的情况下，默认的推流目录时`/ffmpeg/video`

- 需要将将宿主机上的视频文件夹目录绑定挂载到推流目录；

- 水印：暂不支持水印功能

- 被推流的视频文件目前仅支持 mp4 格式，且文件名中不能包含空格，可以照以下方式，去除视频文件名中的空格后，再进行推流操作；

### 批量处理 mac 文件名中的空格

打开文件夹目录后，直接多选需要去除空格的文件，在弹出框选择替换文本模式，把空格替换掉就可以了。

### 批量去除 windows 文件名中的空格

将`powershell-title.ps1`文件放在 windos 文件夹目录下，管理员打开 powershell，在当前目录执行`. \powershell-title.ps1`;
