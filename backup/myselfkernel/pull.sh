shopt -s extglob
rm -rfv !(README.md|first1|pull.sh|first2)
shopt -u extglob
#临时备份本仓库readme
mv README.md back.md

svn export https://github.com/ophub/amlogic-s9xxx-armbian/trunk/ ./ --force
sed -i 's/default: "-ophub"/default: ""/g' ./.github/workflows/*
echo 'fucking'
sed -i '/repository_dispatch:/d' ./.github/workflows/*
sed -i 's/secrets.GH_TOKEN/secrets.ACTIONS_TRIGGER_PAT/g' ./.github/workflows/*
sed -i '9s/^/    types: [Build]\n/g' ./.github/workflows/*kernel.yml
sed -i '9s/^/  repository_dispatch:\n/g' ./.github/workflows/*kernel.yml
sed -i 's/-ophub//g' ./*.yml
sed -i 's?ophub/amlogic-s9xxx-armbian@main?Tao173/compile-kernel@main?g' ./*.yml


rm -rf .git
mv first1 .git
cp -Rn  first2/workflows/*  .github/workflows
rm -rf first1 && rm -rf first2
cat .github/workflows/telegram >> .github/workflows/compile-kernel.yml
#备份源仓库readme
mv README.md READMEBACK.md
#恢复本仓库readme
mv back.md README.md