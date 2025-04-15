# Usa l'immagine ufficiale ROS Noetic come base (amd64)
# osrf/ros:noetic-desktop-full include già Ubuntu 20.04 (focal)
FROM --platform=linux/amd64 osrf/ros:noetic-desktop-full

# Imposta variabili d'ambiente per build non interattive e localizzazione
ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=Etc/UTC
ENV LANG=C.UTF-8
ENV LC_ALL=C.UTF-8

# Installa strumenti di sviluppo comuni, dipendenze ROS comuni (MoveIt, Gazebo) e utilities
# Aggiungi qui altri pacchetti che ritieni universalmente utili (es. editors, net-tools)
RUN apt-get update && apt-get install -y --no-install-recommends \
    # Strumenti ROS e build
    python3-catkin-tools \
    python3-pip \
    git \
    python3-rosdep \
    cmake \
    build-essential \
    # MoveIt (pacchetti comuni)
    ros-noetic-moveit \
    # Gazebo (pacchetti comuni)
    ros-noetic-gazebo-ros-pkgs \
    ros-noetic-gazebo-ros-control \
    # Utilities generiche utili
    nano \
    vim \
    iputils-ping \
    net-tools \
    # Pacchetto spesso utile con Gazebo/MoveIt, non disponibile via apt
    # Se non ti serve universalmente, puoi rimuovere il git clone più avanti
    # e il suo build step
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean

# Inizializza rosdep (necessario per installare dipendenze dei pacchetti utente)
# Gli utenti dovranno comunque eseguire 'rosdep update' regolarmente
RUN rosdep init || echo "rosdep already initialized"
RUN rosdep update

# Crea la struttura base per un workspace Catkin (opzionale ma comune)
# L'utente monterà qui il proprio codice sorgente
WORKDIR /home/ros/catkin_ws
RUN mkdir -p src

# Clona gazebo_ros_link_attacher se lo ritieni utile universalmente
# Altrimenti, rimuovi questa sezione e il relativo build step più avanti
WORKDIR /home/ros/catkin_ws/src
RUN git clone https://github.com/pal-robotics/gazebo_ros_link_attacher.git

# Torna alla root del workspace
WORKDIR /home/ros/catkin_ws

# Configura l'ambiente ROS nel bashrc (solo quello base di sistema)
# L'utente dovrà sorgere manualmente il setup.bash del proprio workspace
# dopo averlo compilato (es. `source devel/setup.bash`)
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc

# [OPZIONALE] Compila i pacchetti clonati universalmente (es. gazebo_ros_link_attacher)
# Se non hai clonato nulla di generico, puoi rimuovere questo RUN
RUN /bin/bash -c 'source /opt/ros/noetic/setup.bash && \
    catkin build gazebo_ros_link_attacher'

# [OPZIONALE] Aggiungi il source del workspace generale (solo se hai compilato qualcosa sopra)
# Nota: Questo potrebbe essere fuorviante se l'utente si aspetta che il *proprio* workspace
# venga automaticamente sorgente. Forse è meglio ometterlo.
# RUN echo "source /home/ros/catkin_ws/devel/setup.bash" >> ~/.bashrc

# Imposta il comando di default all'avvio del container
CMD ["/bin/bash"]