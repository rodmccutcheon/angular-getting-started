FROM node:14.20-alpine as node-angular-cli

#Linux setup
RUN apk update \
  && apk add bash \
  && apk add git \
  && apk add openssh \
  && apk add --update alpine-sdk \
  && apk del alpine-sdk \
  && rm -rf /tmp/* /var/cache/apk/* *.tar.gz ~/.npm \
  && npm cache verify \
  && sed -i -e "s/bin\/ash/bin\/sh/" /etc/passwd

RUN mkdir /getting-started/
RUN chmod 777 /getting-started/
RUN chown -R root:root /getting-started//

RUN git clone git@bitbucket.org:organicresponse/tellus-ui.git /tellus-ui
WORKDIR getting-started/

#Angular CLI
RUN npm install -g @angular/cli

EXPOSE 4200

RUN npm install

ENTRYPOINT ["npm", "run", "start"]
