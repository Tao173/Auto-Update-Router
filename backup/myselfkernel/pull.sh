shopt -s extglob
rm -rfv !(README.md|first1|pull.sh|back)
shopt -u extglob
#临时备份本仓库readme
mv README.md back.md

svn export https://github.com/ophub/amlogic-s9xxx-armbian/trunk/ ./ --force
sed -i 's/default: ""/default: ""/g' ./.github/workflows/*
echo 'fucking'
sed -i '/repository_dispatch:/d' ./.github/workflows/*
sed -i 's/secrets.GH_TOKEN/secrets.ACTIONS_TRIGGER_PAT/g' ./.github/workflows/*
sed -i '9s/^/    types: [Build]\n/g' ./.github/workflows/*kernel.yml
sed -i '9s/^/  repository_dispatch:\n/g' ./.github/workflows/*kernel.yml
sed -i 's?Tao173/compile-kernel@main?Tao173/compile-kernel@main?g' `grep -rl "Tao173/compile-kernel@main" ./`
sed -i 's///g' ` grep -e  -rl ./`

rm -rf .git
mv first1 .git
cp -rf back/*  .github/workflows
rm -rf first1
cat .github/workflows/telegram >> .github/workflows/compile-kernel.yml

#备份源仓库readme
mv README.md READMEBACK.md
#恢复本仓库readme
mv back.md README.md