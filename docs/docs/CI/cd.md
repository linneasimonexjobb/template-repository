Deployment to providers like AWS and Azure can be done using a continuous delivery method in GitHub Action.

Though this template does not provide any guide to deploy to these instances, it provides a template how to either create an artifact that is generated when running the deployment or creating a Docker image to be deployed to GitHub Packages.


## Docker
Docker is a platform that enables developers to build, package, and distribute applications and their dependencies in a standardized and consistent way. It uses containerization technology to create lightweight, portable, and self-sufficient containers that can run on any machine with the Docker platform installed, regardless of the underlying operating system.

Here's a breakdown of how Docker can be used in a package deployment on GitHub:

- **Containerization**: Docker allows you to package your application along with its dependencies and configuration files into a container. This container encapsulates the application's runtime environment, making it easy to deploy consistently across various environments.

- **Dockerfile**: To use Docker in a package deployment on GitHub, you first create a Dockerfile. This file contains instructions for building a Docker image, specifying the base image, environment variables, application dependencies, and other configurations required to run your application within a Docker container.

- **Build Docker Image**: With the Dockerfile in place, you build a Docker image using the docker build command. This command reads the instructions from the Dockerfile and creates a Docker image that encapsulates your application and its dependencies.

- **Container Registry**: Once the Docker image is built, it can be pushed to a container registry, such as Docker Hub or GitHub Container Registry (now GitHub packages). This step is crucial for sharing and distributing your Docker image so that it can be easily pulled and deployed on various systems.

## CD template

A template of a CD is created in `.github/workflows/deployment.yml`

```yaml
---
name: deployment-template
on:
  pull_request:
    types:
      - closed

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}

jobs: 
  docker_image:
    
    if: github.event.pull_request.merged == true
    name: Build and create a docker image
    runs-on: ubuntu-22.04
    timeout-minutes: 10 #job times out after 10 mins
    permissions:
      contents: read
      packages: write
    steps:
      - name: Checkout
        uses: actions/checkout@v4

      - name: Log in to the Container registry
        uses: docker/login-action@65b78e6e13532edd9afa3aa52ac7964289d1a9c1
        with:
          registry: ${{ env.REGISTRY }}
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}
      - name: Extract metadata (tags, labels) for Docker
        id: meta
        uses: docker/metadata-action@9ec57ed1fcdbf14dcef7dfbe97b2010124a938b7
        with:
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }} # Create image with metadata naming

      - name: Build and push Docker image
        uses: docker/build-push-action@f2a1d5e99d037542a71f64918e516c093c6f3fc4
        with:
          context: .
          push: true
          tags: ${{ steps.meta.outputs.tags }}
          labels: ${{ steps.meta.outputs.labels }}
      # ... If deploying to AWS or azure continue here

# Note, if one want to upload a folder or file instead to github. You may use a artifacts. See https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts


```

This template creates a docker image and releases it to the package manager in GitHub. To deploy to AWS or Azue further steps needs to be taken.

If a docker image is not avaiable to deploy, one may use the github artifacts to deploy an artifact to the specific deployment. This would be created by using:

```yaml

  - name: 'Upload Artifact'
    uses: actions/upload-artifact@v3
    with:
      name: my-artifact
      path: my_file.txt

```

See more at [storing workflow data as artifacts](https://docs.github.com/en/actions/using-workflows/storing-workflow-data-as-artifacts)


