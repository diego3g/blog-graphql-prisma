FROM node:alpine

RUN mkdir /app
WORKDIR /app

COPY package*.json ./
RUN npm install

COPY . ./
RUN npm run build

EXPOSE 4000
CMD ["npm", "start"]
