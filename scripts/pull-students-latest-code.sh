set -e -o pipefail

function main() {
  pwd
  rm -rf .git
  mkdir -p "submissions"
  cd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID
  repos=$(ls $ASSIGNMENT_NAME-submissions)
  for repo in $repos; do
    echo "Removing git from $repo"
    rm -rf $repo/.git
  done
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
echo $PROJECT_DIR
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
