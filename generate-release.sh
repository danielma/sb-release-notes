#!/bin/bash

first_commit="HEAD"
if [[ -n "$1" ]]; then
	first_commit=$1
fi

second_commit=""
if [[ -n "$2" ]]; then
	second_commit=$2
fi

project_name=$(git remote -v | grep fetch | sed 's/.*\/\(.*\)\(\.git\)\? (fetch).*/\1/')
name=$(git config --get user.name)
if [[ -z "$name" ]]; then
    name=$(whoami)
fi

git_first_hash=$(git rev-parse $first_commit) 
git_short_first_hash=$(sed 's/^
git_long_hash=$(git rev-parse HEAD)
files_changed=$(git diff --name-only HEAD~1 HEAD)

format=$(cat <<EOF
$name
<ul>
	<li>
		$project_name
    	<ul>
    		<li>
    			<a href="http://github.com/saddlebackdev/$project_name/commit/$git_long_hash">$git_short_hash</a>
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
