source ./config_file.sh

cd $PROJECT_PATH

commit_hashes=$(git rev-list --no-merges origin/$RAMA_PRINCIPAL..origin/$RAMA_ACTUAL | tac)

trap 'handle_error' ERR

function handle_error() {
    echo "Error encontrado. Revertiendo cambios..."
    echo "--------------------------------------------------------"

    git checkout $RAMA_ACTUAL
    git cherry-pick --abort
    git reset --hard
    git branch -D $RAMA_CAMBIOS
    git push origin --delete $RAMA_CAMBIOS

    echo ""--------------------------------------------------------""
    echo "Cambios revertidos"
    exit 1
}
git checkout $RAMA_ACTUAL
git pull origin $RAMA_ACTUAL

if git show-ref --verify --quiet "refs/heads/$RAMA_DESARROLLO"; then
    git branch -D $RAMA_DESARROLLO
fi

git pull

echo $"Posicionandose en rama $RAMA_DESARROLLO" 
git checkout $RAMA_DESARROLLO


git checkout -b $RAMA_CAMBIOS

for commit_hash in "${commit_hashes[@]}"; do
    echo ""--------------------------------------------------------""
    echo $"Haciendo cherry-pick a:" 
    echo $commit_hash  

    git cherry-pick $commit_hash

    echo ""--------------------------------------------------------""
done

git push --set-upstream origin $RAMA_CAMBIOS

trap - ERR

echo "Proceso completado con éxito."