FROM ubuntu

MAINTAINER Charles Bitter "cbitter78@gmail.com"


# Taken from here: https://gist.github.com/kwk/55bb5b6a4b7457bef38d
#
# this forces dpkg not to call sync() after package extraction and speeds up
# install
RUN echo "force-unsafe-io" > /etc/dpkg/dpkg.cfg.d/02apt-speedup
# # we don't need and apt cache in a container
RUN echo "Acquire::http {No-Cache=True;};" > /etc/apt/apt.conf.d/no-cache

# Install ruby 2.0
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y install software-properties-common

RUN apt-add-repository -y ppa:brightbox/ruby-ng
RUN apt-get update
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get install -y zlib1g-dev libxslt-dev libxml2-dev build-essential ruby2.2 ruby2.2-dev \
  git git-core zsh ssh host vim curl 
RUN gem install nokogiri -- --use-system-libraries=true --with-xml2-include=/usr/include/libxml2
RUN gem install --no-rdoc --no-ri rspec rake sinatra puma bundler

EXPOSE 80

ADD run.sh /run.sh
RUN mkdir /pxe/
WORKDIR /pxe
ADD lib /pxe/lib
ADD spec /pxe/spec
ADD public /pxe/public
ADD Gemfile /pxe/
ADD config.ru /pxe/
ADD pxe_monster.rb /pxe/
RUN bundle install --without development


# Unless a command is specified in the command line run this
CMD /run.sh
RUN chmod +x /run.sh