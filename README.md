# Bluefin-Niri

# Purpose

Bluefin with Niri added.

# How to Use

## Template

Select `Use this Template` and create a new repository from it. To enable the workflows, you may need to go the `Actions` tab of the new repository and click to enable workflows.

## Containerfile

This file defines the operations used to customize the selected image. It contains examples of possible modifications, including how to:
- change the upstream from which the custom image is derived
- add additional RPM packages
- add binaries as a layer from other images

## Building an ISO

Modify `iso.toml` to point to your custom image before generating an ISO.

- (Steps in progress)

## Workflows

### build.yml

This workflow creates your custom OCI image and publishes it to the Github Container Registry (GHCR). By default, the image name will match the Github repository name.
