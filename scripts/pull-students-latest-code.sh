set -e -o pipefail

function main() {
  pwd
  mkdir -p submissions
  cd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID
  repos=$(ls $ASSIGNMENT_NAME-submissions)
  for repo in $repos; do
    rm -rf $repo/.git
  done
  git config --global user.name "polling-students-repos"
  git config --global user.email "polling-repos@gmail.com"
  git add .
  git commit -m "Pulling latest code from students"
  git push
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
echo $PROJECT_DIR
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
