FROM continuumio/miniconda3

# Définit le répertoire de travail dans le conteneur
WORKDIR /app

# Copie les fichiers de ton application
COPY environment.yml ./
COPY app_stl2_fire_detection_V2.ipynb ./
COPY .env ./
COPY gee_credentials.json ./
COPY data_reference_feux.yaml ./

ENV GOOGLE_APPLICATION_CREDENTIALS=./gee_credentials.json
ENV GOOGLE_CLOUD_PROJECT=ee-surfor

RUN conda env create -f environment.yml

# Active l'environnement Conda
SHELL ["conda", "run", "-n", "gis311", "/bin/bash", "-c"]

RUN conda install -n gis311 -c conda-forge voila

# Expose le port utilisé par Voilà (par défaut 8866)
EXPOSE 8080

# Définit la commande pour démarrer Voilà
ENTRYPOINT ["conda", "run", "--no-capture-output", "-n", "gis311", "voila", \
    "--port=8080", \
    "--no-browser", \
    "--Voila.ip=0.0.0.0", \
    "--VoilaConfiguration.allow_origin='*'", \
    "--VoilaConfiguration.allow_credentials=True", \
    "app_stl2_fire_detection_V2.ipynb"]
