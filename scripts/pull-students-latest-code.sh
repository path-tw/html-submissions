set -e -o pipefail

function pullAssignmentRepos() {
  ASSIGNMENT_NAME="$1"
  ASSIGNMENT_ID="$2"

  cd submissions
  rm -rf "$ASSIGNMENT_NAME-submissions"
  gh classroom clone student-repos -a $ASSIGNMENT_ID

  repos=$(ls $ASSIGNMENT_NAME-submissions)
  for repo in $repos; do
    echo "Removing git from $repo"
    rm -rf $repo/.git
  done
}

rm -rf .git
pullAssignmentRepos "my-cart" 622206
pullAssignmentRepos "my-clone" 624979
