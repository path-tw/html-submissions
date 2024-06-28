set -e -o pipefail

function main() {
  pwd
  ls
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
echo $PROJECT_DIR
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
