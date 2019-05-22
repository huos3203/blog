#!/bin/sh

#  postsUpdated.sh
#  HexoDeploy
#
#  Created by pengyucheng on 22/12/2016.
#
## 脚本不支持带空格的文件名
#脚本更新博客更新时间
echo "执行 draftsUpdated.sh 文件"
#将Git配置变量 core.quotepath 设置为false，就可以解决中文文件名称在这些Git命令输出中的显示问题
git config --global core.quotepath false
git status -s > modified.txt
#shell命令过滤文件路径，写入到postfile.txt临时文件中
#原理：根据git status -s 输入来筛选博文文件的更新：文件必须是处于M状态，文件名不能包含空格
#如果文件名中存在空格：git status 输入就会存在双引号
# 例如：M "_posts/Awsome Apple Develop Guide.md"
#sed 's#My#Your#g' datafile
#紧跟在s命令后的字符就是查找串和替换串之间的分隔符。分隔符默认为正斜杠，但可以改变。无论什么字符（换行符、反斜线除外），只要紧跟s命令，就成了新的串分隔符。
cat modified.txt | grep 'M.*_drafts' | sed 's#^.*M.*_drafts/##g' | sed 's/md"/md/g' > postfile.txt
cat modified.txt | grep 'R.*_drafts' | sed 's#^.*R.*_drafts/##g' | sed 's/md"/md/g' >> postfile.txt
#"重定向法 管道法: cat $FILENAME | while read LINE"
if [ -f postfile.txt ]; then
    #读取文件路径，找到文件替换文件内容
    cat postfile.txt | while read line
    do
        #逐行循环开始
        postPath="source/_drafts/${line}"
        titlemd="${line##*/}"   #  ##*/ 表示从左边开始删除最后（最右边）一个 / 号及左边的所有字符
        title="${titlemd%%\.*}"
        echo "博客：$title $postPath 博客类型：${categories}"
        if [ -f "${postPath}" ]; then

            sed -i "s/<#.*#>//g" "${postPath}"
            #直接修改文件内容(危险动作) updated:值
            createdLine=$(cat ${postPath} | grep 'date: 创建时间')  #当初始值"创建时间"时才更新
            updatedLine=$(cat ${postPath} | grep 'updated: ') # 每次执行都更新
            categoriesLine=$(cat ${postPath} | grep 'categories: ')
            titleLine=$(cat ${postPath} | grep 'title: ')
            time=`date '+%Y-%m-%d %H:%M:%S'`

            #博客标题
            if [ "$titleLine" != "" ]; then
                echo "--开始替换 title: --"
                sed -i "s/${titleLine}/title: ${title}/g" "${postPath}"
            else
                echo "title: 已命名"
            fi
            #替换创建时间
            if [ "$createdLine" != "" ]; then
                echo "--开始替换 date: --"
                sed -i "s/${createdLine}/date: ${time}/g" "${postPath}"
            else
                echo "date: 不存在"
            fi
            #替换更新时间
            if [ "$updatedLine" != "" ]; then
                echo "--开始替换 updated: --"
                sed -i "s/${updatedLine}/updated: ${time}/g" "${postPath}"
            else
                echo "updated: 不存在"
            fi

    #        exit 0
        else
            echo "${postPath}不存在"
        fi
    done

    echo "移除临时文件"
    rm -r modified.txt postfile.txt # _posts/.\!9*
fi
