FROM node

WORKDIR /usr/nextjs-app/

COPY package*.json /usr/nextjs-app/

RUN npm install

COPY . /usr/nextjs-app/

EXPOSE 3000

CMD ["npm", "run", "dev"]