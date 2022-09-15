FROM node:14-alpine


COPY package*.json ./

RUN npm install

# Bundle app source
COPY . .

EXPOSE 3000

CMD ["npm", "run", "start"]