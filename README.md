# Container recipe for Metopizer

This recipe can be used to create a container for running Metopizer
software to convert tVCDU data from direct reception to EPS L0 format.

## Building

Run

```bash
podman build -t metopizer .
```

to build the container. Replace `podman` with `docker` if you are
using Docker.

## Configuration

The only configuration needed is the MPHR configuration for the
platform being processed.  See `mphr_configs/` directory and adjust as
necessary.  These files are used automatically based on the filename,
so keep the configuration filenames as-is.  The satellite is assumed
to be in the tVCDU filename, and it should be either `METOP-B` or
`METOP-C`.

## Running

When running with Podman/Docker, three directories need to be mounted:

* directory for the raw tVCDU data
  - mounted to `/data/raw` within the container
* directory for the output EPS L0 data
  - mounted to `/data/l0` within the container
* directory for the Multi-Mission Administrative Messages (MMAM)
  - mounted to `/data/mmam` within the container

The filename of the tVCDU file to be processed is given as an argument.

```bash
podman run \
    --rm \
    # Directory where the raw tVCDU data are
    -v /host/path/metopizer_raw:/data/raw:z \
    # Directory where the EPS L0 result files are placed
    -v /host/path/metopizer_l0:/data/l0:z \
    # Directory for the saved MMAM files
    -v /host/path/metopizer_mmam:/data/mmam \
    # Name of the container image
    metopizer \
    # Name of the file to be processed
    rawdata_METOP-C_AHRPT_f1_ch1_20250226T093702Z_20250226T095222Z_20250226T093702Z_1LkeFZLO1_vcdu1_32723.data
```
