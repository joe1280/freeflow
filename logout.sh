#!/bin/sh

_used="`expr $bytes_received + $bytes_sent`"
_used="`expr $_used / 1024`"
curl http://cnimabi.nxbhwk.cn/index.php/User/usedata.html?username=$username\&num=$_used