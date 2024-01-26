FROM ubuntu:jammy
MAINTAINER Chinh Hoang <chinhguitar@gmail.com>

ENV BUILD_PACKAGES git curl wget zsh nano vim tmux tree htop locales tzdata powerline fonts-powerline \
                   sudo systemd build-essential python-dev python3-dev cmake \
                   gnupg2 libpq-dev libmagickwand-dev libgd-dev imagemagick \
                   telnet net-tools
ENV DEBIAN_FRONTEND=noninteractive \
    LANG=en_US.UTF-8 LANGUAGE=en_US:en LC_ALL=en_US.UTF-8 \
    TZ=Asia/Ho_Chi_Minh

RUN echo $TZ > /etc/timezone && \
    apt-get update && apt-get -y upgrade && apt-get install -y $BUILD_PACKAGES && \
    locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 LANGUAGE=en_US.en LC_ALL=en_US.UTF-8 && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && dpkg-reconfigure -f $DEBIAN_FRONTEND tzdata && \
    rm -rf /var/lib/apt/lists/* && rm -rf /var/cache/apt/* && apt-get clean

RUN git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all

RUN curl -sSL https://github.com/robbyrussell/oh-my-zsh/raw/master/tools/install.sh | zsh && \
    git clone https://github.com/zsh-users/zsh-autosuggestions.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions && \
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting && \
    sed -ie "s/plugins=(git)/plugins=(git common-aliases zsh-autosuggestions zsh-syntax-highlighting yarn)/g" ~/.zshrc
RUN echo "export HISTSIZE=999999999" >> ~/.zshrc && \
    echo "export SAVEHIST=999999999" >> ~/.zshrc && \
    echo "setopt HIST_IGNORE_ALL_DUPS" >> ~/.zshrc

ARG RUBY_VERSION
ARG BUNDLER_VERSION
RUN mkdir ~/.gnupg && echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf && \
    gpg2 --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB && \
    curl -sSL https://get.rvm.io | bash -s stable --ruby=$RUBY_VERSION && \
    echo "source /usr/local/rvm/scripts/rvm" | tee -a ~/.bashrc ~/.zshrc
RUN rm -rf /usr/local/rvm/rubies/ruby-$RUBY_VERSION/lib/ruby/gems/$RUBY_VERSION/specifications/default/* && \
    bash -c "source /usr/local/rvm/scripts/rvm && gem install bundler -v $BUNDLER_VERSION && gem update --system && gem install colorls" && \
    echo 'alias cl="colorls -Al --sd"' >> ~/.zshrc

ARG NVM_VERSION
ARG NODE_VERSION
ARG YARN_VERSION
RUN curl -sSL https://github.com/creationix/nvm/raw/$NVM_VERSION/install.sh | bash && \
    bash -c "source $HOME/.nvm/nvm.sh && nvm install $NODE_VERSION && nvm alias default $NODE_VERSION && nvm use $NODE_VERSION"
RUN echo 'export NVM_DIR="$HOME/.nvm"' >> ~/.zshrc && \
    echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm' >> ~/.zshrc && \
    echo '[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion' >> ~/.zshrc
RUN zsh -c "source ~/.zshrc; curl -o- -L https://yarnpkg.com/install.sh | bash -s -- --version=$YARN_VERSION" && \
    echo 'export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"' >> ~/.zshrc

ARG REDIS_VERSION
RUN curl -O http://download.redis.io/releases/redis-$REDIS_VERSION.tar.gz && \
    tar xzvf redis-$REDIS_VERSION.tar.gz && \
    cd redis-$REDIS_VERSION && \
    make && make install

ARG WORKSPACE
WORKDIR $WORKSPACE

COPY Gemfile Gemfile.lock ./
RUN /usr/bin/zsh -c "source $HOME/.zshrc && bundle install --jobs 4 --retry 3 --quiet"

# COPY package.json yarn.lock ./
# RUN /usr/bin/zsh -c "source $HOME/.zshrc && yarn install"

COPY ./ ./

ARG RAILS_PORT
ENV RAILS_PORT=$RAILS_PORT
EXPOSE $RAILS_PORT
CMD /usr/bin/zsh
# CMD /usr/bin/zsh -c "source $HOME/.zshrc && redis-server --daemonize yes && bundle exec rails server --port=3000 --binding=0.0.0.0"
