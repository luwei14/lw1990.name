#!/bin/sh

site_title='卢巍(Wei Lu)'
echo $site_title
page_head(){
  local title="$1"
  cat <<EOF
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>$title</title>
    <link rel="stylesheet" type="text/css" href="/static/lw1990.css">
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src="https://www.googletagmanager.com/gtag/js?id=UA-61531951-2"></script>
    <script>
      window.dataLayer = window.dataLayer || [];
      function gtag(){dataLayer.push(arguments);}
      gtag('js', new Date());

      gtag('config', 'UA-61531951-2');
    </script>
  </head>
  <body>
    <div>
EOF
}

page_foot(){
  cat <<EOF
      <hr/>
      <footer>
        <a href="/">$site_title</a>
      </footer>
    </div>
  </body>
</html>
EOF
}

genpage(){
  page_head "$site_title" > $2
  cat $1 | ./mdrender.py >> $2
  page_foot >> $2
}

pages(){
  for pg in $1/*.md
    do
      filename=${pg##*/}
      filename=${filename%.*}.html
      echo generate page $filename
      genpage $pg $2/$1/$filename
  done
}

action=$1
shift
$action "$@"
