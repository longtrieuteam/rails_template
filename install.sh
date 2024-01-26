[[ -z "${APP_NAME}" ]] && AppName="rails_template_$RANDOM" || AppName="${APP_NAME}"
git clone git@github.com:longtrieuteam/rails_template.git $AppName
cd $AppName
gem install activesupport
ruby generate.rb $AppName
rm README.md install.sh generate.rb
mv README.md.template README.md
cp .env.template .env
rm -rf .git
