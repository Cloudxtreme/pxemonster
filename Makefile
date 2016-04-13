
VERSION=0.0.3
RELEASE=0

COLOR_NORMAL=""
COLOR_RESET="\033[m"
COLOR_BOLD="\033[1m"
COLOR_RED="\033[31m"
COLOR_GREEN="\033[32m"
COLOR_YELLOW="\033[33m"


default: build

test: clean
	@docker-compose up --allow-insecure-ssl
	@docker-compose rm --force

spec_test:
	@bundle install 
	@bundle exec rspec -f d

build: 
	@echo ${COLOR_BOLD}➭${COLOR_RESET} ${COLOR_GREEN}Building Version ${VERSION}-${RELEASE}${COLOR_RESET}
	@docker build --rm -q -t cbitter78/pxemonister:${VERSION}-${RELEASE} .

publish: build
	@echo ${COLOR_BOLD}➭${COLOR_RESET} ${COLOR_GREEN}Publishing Version ${VERSION}-${RELEASE}${COLOR_RESET}
	@docker push cbitter78/pxemonister:${VERSION}-${RELEASE}

clean:
	@echo ${COLOR_BOLD}➭${COLOR_RESET} ${COLOR_GREEN}Cleaning artifacts${COLOR_RESET}
	@rm -rf .bundle
	@rm -rf Gemfile.lock
