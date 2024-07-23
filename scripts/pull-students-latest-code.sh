set -e -o pipefail
htmlStart="<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Submissions</title>
    <style>
      li {
        margin: 10px;
      }

      a {
        text-decoration: none;
        color: #000;
      }

      a:hover {
        color: #f00;
      }

      span {
        margin-left: 10px;
        color: teal;
      }
    </style>
  </head>
  <body>
    <ol>"
htmlEnd="</ol></body></html>"

function getLastUpdatedTime {
  repo=$1
  pushd $repo
  # Get the timestamp of the latest commit
  commit_timestamp=$(git log -1 --format=%cd --date=iso)

  # Convert commit timestamp to epoch time
  commit_epoch=$(date -d "$commit_timestamp" +%s)

  # Get the current time in epoch
  current_epoch=$(date +%s)

  # Calculate the difference in seconds
  difference=$((current_epoch - commit_epoch))

  # Convert the difference to human-readable format (days, hours, minutes, seconds)
  days=$((difference / 86400))
  hours=$(( (difference % 86400) / 3600 ))
  minutes=$(( (difference % 3600) / 60 ))
  seconds=$(( difference % 60 ))

  message="Updated:"

  if [ "$days" -gt 0 ]; then
    message="${message} ${days} days,"
  fi

  if [ "$hours" -gt 0 ]; then
    message="${message} ${hours} hours,"
  fi

  if [ "$minutes" -gt 0 ]; then
    message="${message} ${minutes} minutes,"
  fi

  if [ "$seconds" -gt 0 ]; then
    message="${message} ${seconds} seconds"
  fi
  popd

  echo "$message ago"
}

function pullAssignmentRepos() {
  ASSIGNMENT_NAME="$1"
  ASSIGNMENT_ID="$2"
  studentsList=""

  pushd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID

  pushd "$ASSIGNMENT_NAME-submissions"
  repos=$(ls)
  for repo in $repos; do
    echo "Removing git from $repo"
    lastUpdatedTime=$(getLastUpdatedTime "$repo")
    # studentsList+="<li><a href=\"./${repo}\">${repo}</a><span>${lastUpdatedTime}</span></li>"
    studentsList+="<li><a href=\"./${repo}\">${repo}</a></li>"
    rm -rf .git
  done
  code=$htmlStart$studentsList$htmlEnd
  echo $code > index.html
  popd
  popd
}

rm -rf .git
pullAssignmentRepos "my-cart" 622206
pullAssignmentRepos "my-clone" 624979
pullAssignmentRepos "css-flex" 627049
pullAssignmentRepos "css-grid" 630213
pullAssignmentRepos "css-position" 630229
