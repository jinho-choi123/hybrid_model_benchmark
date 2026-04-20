FROM nvcr.io/nvidia/cuda:12.6.3-devel-rockylinux9

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV UV_LINK_MODE=copy
ENV PATH=/root/.local/bin:${PATH}

RUN dnf -y update && dnf -y install \
    bash \
    ca-certificates \
    curl-minimal \
    git \
    zip \
    tmux \
    python3 \
    python3-pip \
    @"Development Tools" \
    unzip \
    && dnf clean all

RUN curl -LsSf https://astral.sh/uv/install.sh | sh

RUN curl -fsSL https://bun.com/install | bash

RUN curl -fsSL https://claude.ai/install.sh | bash

WORKDIR /workspace

CMD ["bash"]
