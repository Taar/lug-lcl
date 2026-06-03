# Hackforge LUG - Linux Command Line

This is part of a workshop that was hosted at [Hackforge](https://hackf.org) as part of the Linux User Group.

> [!IMPORTANT]
> Don't use this container in production environments. It should only be used for educational purposes.

## Build Container

```bash
podman build . -t lug-lcl:latest
```

## Run the Container

```bash
# if built locally
podman run -it --rm lug-lcl
```
