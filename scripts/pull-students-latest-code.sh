set -e -o pipefail

function main() {
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
