#!/bin/bash

usage="$(basename "$0") [first commit] [second commit] -- program to generate release notes for saddleback devs

where:
    -h             show this help text
    first commit   used as base for compare - default: HEAD~1
    second commit  used to calculate changed files - default: HEAD

commits can be any valid git commit reference - SHA value or HEAD~x"

seed=42
while getopts ':h:' option; do
  case "$option" in
    h) echo "$usage"
       exit
       ;;
    :) printf "missing argument for -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
   \?) printf "illegal option: -%s\n" "$OPTARG" >&2
       echo "$usage" >&2
       exit 1
       ;;
  esac
done
shift $((OPTIND - 1))

first_commit="HEAD~1"
if [[ -n "$1" ]]; then
  first_commit=$1
fi

second_commit="HEAD"
if [[ -n "$2" ]]; then
  second_commit=$2
fi

project_name=$(git remote -v | grep fetch | perl -pe 's|.+/(.+?)(\.git)? \(fetch\).*|\1|')
name=$(git config --get user.name)
if [[ -z "$name" ]]; then
    name=$(whoami)
fi

long_to_short="s/^\(.\{7\}\).*/\1/"

git_first_hash=$(git rev-parse $first_commit)
git_first_hash_short=$(echo $git_first_hash | sed $long_to_short)
git_second_hash=$(git rev-parse $second_commit)
git_second_hash_short=$(echo $git_second_hash | sed $long_to_short)

files_changed=$(git diff --name-only $git_first_hash $git_second_hash)

if [[ "$first_commit" = "$second_commit~1" ]]; then
  href="commit/$git_second_hash"
  text=$git_second_hash_short
else
  href="compare/$git_first_hash...$git_second_hash"
  text="$git_first_hash_short...$git_second_hash_short"
fi

format=$(cat <<EOF
$name
<ul>
  <li>
    $project_name
      <ul>
        <li>
          <a href="http://github.com/saddlebackdev/$project_name/$href">$text</a>
          <ul>
EOF
)

for f in $files_changed
do
  format="$format<li>$f</li>"
done

format="$format</ul></li></ul>"

echo -e "$format" > release-notes.html

explorer release-notes.html