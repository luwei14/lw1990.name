#!/bin/sh
site_title="卢 威(LU WEI)"
pagesdir="pages/"
postsdir="posts/"
output_pages="outputs/pages/"
output_posts="outputs/posts/"

page_head(){
    local title="$1"
    cat <<EOF
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width">
        <meta charset="utf-8" />
        <title>$title</title>
        <link href="../static/style.css" rel="stylesheet">
    </head>
    <body>
        <h1 class="maintitle"> <a href="/">$site_title</a></h1>
EOF
}

page_foot(){
    cat <<EOF
        <footer>
            Copyright &copy; <a href="/">$site_title</a>.
        </footer>
    </body>
</html>
EOF
}

header() {
    sed $2'q;d' $1 | sed 's/^% //'
}

index(){
    page_head "卢 威" > $2
    cat $1 | ./mdrender.py >> $2
    cat <<EOF >> $2
        <h1>Posts</h1>
EOF
    latest_posts | while read line
    do
        echo $line
        date=`echo $line|cut -d"|" -f1`
        page=`echo $line|cut -d"|" -f2`
        title=`echo $line|cut -d"|" -f3`
        cat <<EOF >> $2
        <li>
            $date<br>
            <a href='posts/$page'>$title</a>
        </li>
EOF
    done
    page_foot >> $2
}

genlist(){
    latest_posts | while read line
    do
        #echo $line
        date=`echo $line|cut -d"|" -f1`
        page=`echo $line|cut -d"|" -f2`
        title=`echo $line|cut -d"|" -f3`
        cat <<EOF
        <li>
            $date<br>
            <a href='posts/$page'>$title</a>
        </li>
EOF
    done
}

latest_posts(){
    for p in $postsdir*.md
        do
            pfname=${p##*/}
            pfname=${pfname%.*}
            title=$(header $p 1)
            printf "%s|%s|%s\n" $(header $p 2) $pfname.html "$title"
            #echo $(header $p 2) ${pfname%.*}
    done | sort -r | head -n5
}

page(){
    page_head "卢 威" > $2
    cat $1 | ./mdrender.py >> $2
    page_foot >> $2
}

post(){
    local target title date

    input=$1
    target=$2
    title=$(header $1 1)
    date=$(header $1 2)
    page_head "$title" > $target
    sed '1,2d' $input | ./mdrender.py >> $target
    page_foot >> $target
}

pages(){
    for pg in $pagesdir*.md
        do
            filename=${pg##*/}
            filename=${filename%.*}.html
            echo $filename
            ./genpage.sh page $pg $output_pages$filename
    done
}

posts(){
    for jr in $postsdir*.md
        do
            filename=${jr##*/}
            filename=${filename%.*}.html
            echo $filename;
            ./genpage.sh post $jr $output_posts$filename
    done
}

action=$1
shift
$action "$@"
