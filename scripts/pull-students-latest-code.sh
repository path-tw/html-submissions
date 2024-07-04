set -e -o pipefail

function main() {
  pwd
  rm -rf .git
  mkdir -p "submissions"
  cd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
#  gh classroom clone student-repos -a $ASSIGNMENT_ID
#  repos=$(ls $ASSIGNMENT_NAME-submissions)
#  for repo in $repos; do
#    echo "Removing git from $repo"
#    rm -rf $repo/.git
#  done
  mkdir -p "$ASSIGNMENT_NAME-submissions"
  cd "$ASSIGNMENT_NAME-submissions"
  gh repo clone path-tw/my-cart-naveen-kumar-vadla
  cd my-cart-naveen-kumar-vadla
  rm -rf .git
  ls -la
}

PROJECT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/../"
echo $PROJECT_DIR
pushd "${PROJECT_DIR}" > /dev/null
  main
popd > /dev/null
