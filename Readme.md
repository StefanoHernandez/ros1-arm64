# Progetto ROS Noetic

## Descrizione

Questo progetto utilizza ROS Noetic, una distribuzione del Robot Operating System (ROS) progettata per l'uso con Ubuntu 20.04. È configurato per supportare applicazioni robotiche e simulazioni utilizzando strumenti come Gazebo e MoveIt.

## Prerequisiti

- **Docker**: Assicurati di avere Docker installato sul tuo sistema. Puoi scaricarlo da [qui](https://www.docker.com/get-started).
- **Accesso a Internet**: Necessario per scaricare le immagini Docker e le dipendenze.

## Installazione

1. **Clona il repository**:
   ```bash
   git clone https://github.com/tuo-username/tuo-repo.git
   cd tuo-repo
   ```

2. **Costruisci l'immagine Docker**:
   ```bash
   docker build -t ros_noetic_amd64 .
   ```

3. **Esegui il container**:
   ```bash
   docker run -it --rm -e DISPLAY=host.docker.internal:0 ros_noetic_amd64
   ```

## Utilizzo

Una volta all'interno del container, puoi avviare il ROS Master con il seguente comando:
```bash
roscore
```

Per utilizzare Gazebo, puoi eseguire:
```bash
source /opt/ros/noetic/setup.bash
gazebo
```

## Struttura del Progetto

- `Dockerfile`: File di configurazione per la creazione dell'immagine Docker.
- `src/`: Directory contenente il codice sorgente del progetto.
- `launch/`: Directory per i file di lancio di ROS.

## Contributi

Se desideri contribuire a questo progetto, sentiti libero di aprire una pull request o di segnalare problemi. Ogni contributo è benvenuto!

## Licenza

Questo progetto è concesso in licenza sotto la [MIT License](LICENSE).