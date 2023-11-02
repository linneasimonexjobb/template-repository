Deployment to providers like AWS and Azure can be done using a continious delivery method in GitHub Action.

Though this template does not provide any guide to deploy to these instances, it provides a template how to either create an artifact that is generated when running the deployment or creating a Docker image to be deployed to gihub packages.

## CD template

A template of a CD is created in `.github/workflows/deployment.yml`

```yaml
---
on:
  pull_request:
    types:
      - closed

env:
  REGISTRY: ghcr.io
  IMAGE_NAME: ${{ github.repository }}
  # have to get artifact or run deployment workflow again
jobs: 
  
  if_merged:
    
    if: github.event.pull_request.merged == true
    name: Build and create a docker image
    runs-on: ubuntu-22.04
    timeout-minutes: 30 #job times out after 30 mins
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
          images: ${{ env.REGISTRY }}/${{ env.IMAGE_NAME }}

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

This template creates a docker image 