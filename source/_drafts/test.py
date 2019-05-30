#! /usr/bin/env python
# -*- coding: utf-8 -*-
# vim:fenc=utf-8
#
# Copyright © 2019 u0_a204 <u0_a204@localhost>
#
# Distributed under terms of the MIT license.

"""
总结 
"""
#!/usr/bin/env python
# -*- coding: utf-8 -*-
import os
print(os.name)
# 获取PYTHONPATH环境变量的值
print(os.getenv('PYTHONPATH'))
# 返回当前系统的登录用户名
print(os.getlogin())
# 获取当前进程ID
print(os.getpid())
# 获取当前进程的父进程ID
print(os.getppid())
# 返回当前系统的CPU数量
print(os.cpu_count())
# 返回路径分隔符
print(os.sep)
# 返回当前系统的路径分隔符
print(os.pathsep)
# 返回当前系统的换行符
print(os.linesep)
# 返回适合作为加密使用的、最多3个字节组成的bytes
print(os.urandom(3))
