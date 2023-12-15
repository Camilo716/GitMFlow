source config_file

commit_hashes=($(git rev-list --ancestry-path origin/$RAMA_PRINCIPAL..$RAMA_ACTUAL))

trap 'handle_error' ERR

function handle_error() {
    echo "Error encontrado. Revertir cambios..."
    git checkout $RAMA_ACTUAL
    git branch -D $name_changes_branch
    git push origin --delete $name_changes_branch
    exit 1
}

git pull origin $RAMA_ACTUAL

git branch -D $RAMA_DESARROLLO

git pull origin $RAMA_DESARROLLO

git checkout $RAMA_DESARROLLO

name_changes_branch=$(echo $RAMA_ACTUAL | sed "s/\//$RAMA_DESARROLLO/")

git checkout -b $name_changes_branch

for commit_hash in "${commit_hashes[@]}"; do
    git cherry-pick $commit_hash
done

git push --set-upstream origin $name_changes_branch

trap - ERR

echo "Proceso completado con éxito."