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
        text-decoration: underline #f00;
      }
    </style>
  </head>
  <body>
    <ol>"
htmlEnd="</ol></body></html>"
function pullAssignmentRepos() {
  ASSIGNMENT_NAME="$1"
  ASSIGNMENT_ID="$2"
  studentsList=""

  pushd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID

  repos=$(ls $ASSIGNMENT_NAME-submissions)
  for repo in $repos; do
    echo "Removing git from $repo"
    studentsList+="<li><a href=\"./${repo}\">${repo}</a></li>"
    rm -rf $repo/.git
  done
  code=$htmlStart+$studentsList+$htmlEnd
  echo $code > index.html
  popd
}

rm -rf .git
pullAssignmentRepos "my-cart" 622206
pullAssignmentRepos "my-clone" 624979
