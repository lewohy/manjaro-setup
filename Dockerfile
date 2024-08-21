FROM manjarolinux/base:latest

# Create User
RUN useradd -m lewohy
RUN echo "lewohy:1234" | chpasswd
RUN echo "lewohy ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

USER lewohy
WORKDIR /home/lewohy

# Update System
RUN sudo pacman -Syu --noconfirm

# setup.sh
COPY --chown=lewohy:lewohy setup.sh /home/lewohy/setup.sh
RUN chmod +x /home/lewohy/setup.sh

# Run setup.sh
CMD [ "/bin/bash" ]
