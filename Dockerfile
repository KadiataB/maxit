# Étape 1 : Construire l'application Angular
FROM node:16 AS build

# Définir le répertoire de travail
WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers du projet
COPY . .

# Construire l'application Angular
RUN npm run build --prod

# Étape 2 : Servir l'application avec Nginx
FROM nginx:alpine

# Copier les fichiers construits dans le répertoire Nginx
COPY --from=build /app/dist /usr/share/nginx/html

# Exposer le port 80
EXPOSE 80

# Commande par défaut pour démarrer Nginx
CMD ["nginx", "-g", "daemon off;"]