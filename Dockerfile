FROM debian:stable as lightweight
RUN apt-get update && apt-get install -y build-essential curl gcc git python libxml2

# Install Rust
ENV RUSTUP_HOME=/opt/rust
ENV CARGO_HOME=/opt/cargo
RUN curl https://sh.rustup.rs -sSf | bash -s -- -y && \
    rm -r /opt/rust/toolchains/stable-x86_64-unknown-linux-gnu/share/doc/
ENV PATH=$PATH:/opt/cargo/bin

# Install emscripten
RUN rustup target add wasm32-unknown-emscripten
RUN cd /opt && \
	git clone https://github.com/emscripten-core/emsdk.git &&  \
	cd emsdk && \
	/opt/emsdk/emsdk install latest && \
    rm -r /opt/emsdk/fastcomp/emscripten/tests/ && \
    rm -r /opt/emsdk/.git

ENV EMSDK=/opt/emsdk
ENV PATH=$PATH:/opt/emsdk
RUN emsdk activate latest

ENV PATH=$PATH:/opt/emsdk/fastcomp/emscripten:/opt/emsdk/node/8.9.1_64bit/bin

# Install dependencies for examples
RUN apt-get install -y pkg-config libfreetype6-dev libexpat1-dev cmake vim nano libfontconfig1-dev

# Install hello example
COPY repos/hello-gwasm-runner/ /root/hello-gwasm-runner/
RUN cd /root/hello-gwasm-runner/ && cargo build --release && cargo clean

# Install mandelbrot
RUN cd /root && git clone https://github.com/golemfactory/mandelbrot.git
RUN cd /root/mandelbrot && cargo build --release && cargo clean

# Install gudot
COPY repos/gudot/ /root/gudot/
RUN cd /root/gudot/ && cargo build --release && cargo clean

# Install rust key crackers
COPY repos/key_cracker_rust/ /root/key_cracker_rust/
RUN cd /root/key_cracker_rust/ && cargo build --release && cargo clean

# Install c++ key crackers
COPY repos/key_cracker_cpp/ /root/key_cracker_cpp/
RUN cd /root/key_cracker_cpp/ && \
    mkdir -p build && \
    cd build && \
    emconfigure cmake .. && \
    make -j4

# Install gwasm-runner
RUN curl -L -o /usr/bin/gwasm-runner https://github.com/golemfactory/gwasm-runner/releases/download/0.2.0/gwasm-runner-linux-amd64 && chmod +x /usr/bin/gwasm-runner

RUN cd /root/hello-gwasm-runner 
WORKDIR /root/hello-gwasm-runner
ENV GU_HUB_ADDR=172.30.30.22:61622
ENV CARGO_NET_OFFLINE=true

# Add welcome message
COPY welcome-message.txt /root/welcome-message.txt
RUN echo 'cat /root/welcome-message.txt' >> /etc/bash.bashrc



# Build image for presenter
FROM lightweight as presenter

RUN cd /root/hello-gwasm-runner/ && cargo build --release
RUN cd /root/mandelbrot && cargo build --release
RUN cd /root/gudot/ && cargo build --release
RUN cd /root/key_cracker_rust/ && cargo build --release

