ARG VARIANT="3.12-bookworm"
FROM mcr.microsoft.com/vscode/devcontainers/python:${VARIANT}

RUN pip install -U https://github.com/platformio/platformio-core/archive/master.zip
RUN platformio upgrade
RUN pip install PyYaml

USER vscode

WORKDIR /home/vscode

ARG MARLIN_VERSION="2.1.2.5"
RUN git clone https://github.com/MarlinFirmware/Marlin.git -b ${MARLIN_VERSION} --single-branch

RUN pio run -d Marlin

COPY *.h Marlin/Marlin/

RUN make marlin -C Marlin

FROM scratch

COPY --from=0 /home/vscode/Marlin/.pio/build/mega2560/firmware.hex .
